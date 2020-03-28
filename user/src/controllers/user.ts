import bcrypt from 'bcrypt';
import { Request, Response } from 'express';
// import { validationResult } from 'express-validator';
import jwt from 'jsonwebtoken';
import { Document } from 'mongoose';
import { connect } from '../db/index';
import { LocationModel } from '../models/location';
import { UserModel } from '../models/user';
import { AuthorizationError } from '../util/errors/AuthorizationError';
import { addUserIngredient } from '../util/ingredient';
import { addUserRecipe } from '../util/recipe';

const AVAILABLE_FIELDS: string[] = ['fullName', 'username', '_id'];
const REQUIRED_LOCATION_FIELDS: string[] = ['city', 'province', 'country'];
const JWT_SECRET_KEY: string | undefined = process.env.JWT_SECRET_KEY;

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

async function createUser(user: any): Promise<string> {
    const { email, username, password, fullName, dateOfBirth, location } = user;
    const newUser: Document = new UserModel({
        email,
        username,
        password: bcrypt.hashSync(password, 10),
        fullName,
        timeCreated: Date.now(),
        dateOfBirth,
        token: null,
        location: null,
    });

    if (!location) {
        return registerUser(newUser);
    }

    const isLocationValid = REQUIRED_LOCATION_FIELDS.reduce((acc, prop) => acc && location[prop], true);
    if (!isLocationValid) {
        throw Error('Missing location fields.');
    }

    const { city, province, country } = location;
    return createLocation(city, province, country, newUser)
        .then((userWithLocation: Document) => registerUser(userWithLocation))
        .catch((error: any) => {
            throw error;
        });
}

async function createLocation(city: string, province: string, country: string, user: Document): Promise<Document> {
    try {
        const location: Document = await findLocation(city, province, country);
        user.set('location', location.get('_id'));
        return user.save();
    } catch (error) {
        const newLocation = new LocationModel({ city, province, country });
        return newLocation
            .save()
            .then((doc: Document) => {
                user.set('location', doc.get('_id'));
                return user.save();
            })
            .catch((error: Error) => {
                throw error;
            });
    }
}

async function findLocation(city: string, province: string, country: string): Promise<Document> {
    const location: Document | null = await LocationModel.findOne({ city, province, country });
    if (!location) {
        throw new Error('Location could not be found.');
    }
    return location;
}

async function registerUser(user: Document): Promise<string> {
    return connect()
        .then(() => {
            const username: string = user.get('username');
            return Promise.all([addUserIngredient(username), addUserRecipe(username)]);
        })
        .then(async () => assignNewToken(user))
        .catch((error: Error) => {
            throw error;
        });
}

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

async function getUserToken(token: string): Promise<string> {
    const decoded: any = jwt.verify(token, JWT_SECRET_KEY as string, { maxAge: '168h' });
    const user: Document = await findUser(decoded.username);
    return assignNewToken(user);
}

async function assignNewToken(user: Document): Promise<string> {
    const payload: object = { username: user.get('username'), iat: Date.now() };
    const newToken: string = jwt.sign(payload, JWT_SECRET_KEY as string, { expiresIn: '168h' });
    user.set('token', newToken);
    await user.save();
    return newToken;
}

async function getUserAttributes(username: string): Promise<object> {
    const user: Document = await findUser(username);

    const attributes: any = {};
    for (const field of AVAILABLE_FIELDS) {
        let value: any = user.get(field);
        if (value) {
            if (field.startsWith('_')) {
                field.slice(1);
                value = value.toString();
            }
            attributes[field] = value;
        }
    }
    return attributes;
}

async function findUser(username: string): Promise<Document> {
    return connect()
        .then(() => UserModel.findOne({ username }))
        .then((user: Document | null) => {
            if (!user) {
                throw new AuthorizationError('User could not be found.');
            }
            return user;
        });
}

export {
    getUser,
    postUser,
    getUserAttributes,
    getUserToken,
    assignNewToken,
    createUser,
    findUser,
    findLocation,
    AVAILABLE_FIELDS,
};
