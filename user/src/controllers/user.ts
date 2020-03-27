import { Request, Response } from 'express';
import { Document } from 'mongoose';
import { AuthenticationError } from '../util/errors/AuthenticationError';
import { AuthorizationError } from '../util/errors/AuthorizationError';
import { deleteLocation } from '../util/location';
import { getUserToken, verifyUserToken } from '../util/token';
import { createUser, findUser, getUserAttributes, removeUser } from '../util/user';

const postUser = async (req: Request, res: Response): Promise<Response> => {
    const user = req.body;

    return createUser(user)
        .then((token: string) => {
            if (!token) {
                throw new Error('Failed to register user.');
            }
            return res
                .status(201)
                .set('token', token)
                .send({ message: 'Successfully registered!' });
        })
        .catch((error: any) => res.status(422).json({ error }));
};

const getUser = async (req: Request, res: Response): Promise<Response> => {
    const username: string = req.params.username;
    const token: string | undefined = req.header('token');

    if (token) {
        return getUserToken(token)
            .then((newToken: string) => {
                if (!newToken) {
                    throw new AuthorizationError('');
                }
                return res
                    .status(200)
                    .set('token', newToken)
                    .send({ message: 'Successfully logged in.' });
            })
            .catch((error: Error) => {
                if (error instanceof AuthorizationError) {
                    return res.status(401).send(error);
                } else {
                    return res.status(422).send(error);
                }
            });
    } else {
        return getUserAttributes(username)
            .then((attributes: object) => res.status(200).send({ user: attributes }))
            .catch((error: Error) => res.status(404).send(error));
    }
};

const deleteUser = async (req: Request, res: Response): Promise<Response> => {
    const username: string = req.params.username;
    const token: string | undefined = req.header('token');

    const user: Document = await findUser(username);
    const isAuthorizedUser: boolean = token ? await verifyUserToken(token, username) : false;
    if (!token || !isAuthorizedUser) {
        const error: AuthorizationError = new AuthorizationError('You are not permitted to delete this user.');
        return res.status(401).send(error);
    } else if (user.get('token') !== token) {
        const error: AuthenticationError = new AuthenticationError(
            "The given token does not match the user's current token."
        );
        return res.status(401).send(error);
    }

    const locationId: string = user.get('location');
    return deleteLocation(locationId)
        .then(() => removeUser(username))
        .then(() => res.status(204).send())
        .catch((error: Error) => res.status(404).send(error));
};

export { deleteUser, getUser, postUser };
