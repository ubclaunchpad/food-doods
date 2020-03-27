import { Request, Response } from 'express';
import { AuthorizationError } from '../util/errors/AuthorizationError';
import { getUserToken } from '../util/token';
import { createUser, getUserAttributes } from '../util/user';

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

export { getUser, postUser };
