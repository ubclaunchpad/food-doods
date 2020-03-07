import { Request, Response } from 'express';
import { validationResult } from 'express-validator';
import { Document } from 'mongoose';
import { createUser } from '../models/user';
import { findUser, loginWithToken, registerUser } from '../models/userManager';

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
    const username = req.params.username;
    const token: any = req.header('token');

    if (token) {
        return loginWithToken(token)
            .then((newToken: string | false) => {
                if (newToken) {
                    return res
                        .status(200)
                        .set('token', newToken)
                        .send({ message: 'Successfully logged in.' });
                } else {
                    return res.status(401).json({ message: 'Authorization denied.' });
                }
            })
            .catch((error: any) => {
                return res.status(422).json({ error });
            });
    } else {
        // TODO: change requestedFields into a static array instead of retrieving from request
        // const { requestedFields } = req.body;
        const requestedFields = ['fullName', 'username'];
        const user: Document = await findUser(username);

        const results: any = {};
        for (const field of requestedFields) {
            const value: any = user.get(field);
            if (value) {
                results[field] = value;
            }
        }

        if (Object.keys(results).length > 0) {
            return res.status(200).send({ attributes: results });
        } else {
            return res.status(404).json({ error: 'Requested attributes could not be found.' });
        }
    }
};

export { getUser, postUser };
