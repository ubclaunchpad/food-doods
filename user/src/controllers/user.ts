import { Request, Response } from 'express';
import { validationResult } from 'express-validator';
import jwt from 'jsonwebtoken';
import { Document } from 'mongoose';
import { createUser } from '../models/user';
import { findUser, registerUser } from '../models/userManager';

const postUser = async (req: Request, res: Response): Promise<Response> => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }

    const { email, username, password, fullName, dateOfBirth, city, province, country } = req.body;
    const user: any = { email, username, password, fullName, dateOfBirth, location: { city, province, country } };

    return createUser(user)
        .then((newUser: Document) => {
            return registerUser(newUser);
        })
        .then((token: string) => {
            return res
                .status(201)
                .set('token', token)
                .send({ message: 'Successfully registered!' });
        })
        .catch((error: any) => {
            return res.status(422).json({ error });
        });
};

const getUser = async (req: Request, res: Response): Promise<Response> => {
    const username: string = req.params.username;
    const token: string | undefined = req.header('token');

    if (token) {
        return getUserToken(token)
            .then((newToken: string) => {
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

const getUserToken = async (token: string): Promise<string> => {
    const newToken: string | false = await loginWithToken(token);
    if (!newToken) {
        throw new AuthorizationError('Authorization denied.');
    }
    return newToken;
};

async function loginWithToken(token: string): Promise<string | false> {
    const secretKey: any = process.env.JWT_SECRET_KEY;
    const decoded: any = jwt.verify(token, secretKey, { maxAge: '168h' });

    if (decoded) {
        const user: Document = await findUser(decoded);
        if (user && decoded.username === user.get('username')) {
            return assignNewToken(user);
        }
    }
    return false;
}

function assignNewToken(user: Document): string | false {
    const secretKey: string | undefined = process.env.JWT_SECRET_KEY;
    if (secretKey) {
        const payload: object = { username: user.get('username'), iat: Date.now() };
        const newToken: string = jwt.sign(payload, secretKey, { expiresIn: '168h' });
        user.set('token', newToken);
        return newToken;
    }
    return false;
}

const getUserAttributes = async (username: string): Promise<object> => {
    const requestedFields = ['fullName', 'username', '_id'];
    const user: Document = await findUser(username);

    const attributes: any = {};
    for (const field of requestedFields) {
        const value: any = user.get(field);
        if (value) {
            if (field.startsWith('_')) {
                field.slice(1);
            }
            attributes[field] = value;
        }
    }

    if (Object.keys(attributes).length > 0) {
        return attributes;
    } else {
        throw Error('Requested attributes could not be found.');
    }
};

export { getUser, postUser, assignNewToken };
