import bcrypt from 'bcrypt';
import { Request, Response } from 'express';
// import { validationResult } from 'express-validator';
import jwt from 'jsonwebtoken';
import { Document, Types } from 'mongoose';
import { connect } from '../models/index';
import { LocationModel } from '../models/location';
import { UserModel } from '../models/user';
import { AuthorizationError } from '../util/errors/AuthorizationError';

const AVAILABLE_FIELDS: string[] = ['fullName', 'username', '_id'];
const REQUIRED_LOCATION_FIELDS: string[] = ['city', 'province', 'country'];

const postUser = async (req: Request, res: Response): Promise<Response> => {
    const user = req.body;

    return createUser(user)
        .then((token: string) => {
            if (!token) {
                throw Error('Failed to register user.');
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
    });

    const isLocationValid =
        location &&
        REQUIRED_LOCATION_FIELDS.reduce((acc, prop) => {
            return acc && location[prop];
        }, true);

    if (isLocationValid) {
        return createLocation(location)
            .then(() => getLocationID(location))
            .then((locationId: Types.ObjectId) => {
                newUser.set('location', locationId);
                return newUser.save();
            })
            .then((userWithLocation: Document) => registerUser(userWithLocation))
            .catch((error: any) => {
                throw error;
            });
    }
    return registerUser(newUser);
}

async function createLocation(location: any): Promise<Document> {
    const { city, province, country } = location;
    const loc = new LocationModel({ city, province, country });
    return loc.save();
}

async function getLocationID(location: any): Promise<Types.ObjectId> {
    const { city, province, country } = location;
    const objectId: Types.ObjectId = await new Promise((resolve, reject) => {
        LocationModel.findOne({ city, province, country }, (err: any, loc: Document) => {
            if (err) {
                reject(err);
            }
            resolve(loc._id);
        });
    });
    return objectId;
}

async function registerUser(user: Document): Promise<string> {
    const callback = async (error: any): Promise<string> => {
        if (error) {
            throw error;
        }
        const token: string = assignNewToken(user);
        return (
            user
                .save()
                // .then(() => {
                //     const username: string = user.get('username');
                //     return Promise.all([addUserIngredient(username), addUserRecipe(username)]);
                //     return user.get('username');
                // })
                .then(() => token)
                .catch((err: any) => {
                    throw err;
                })
        );
    };
    return connect(callback);
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
    return loginWithToken(token)
        .then((newToken: string) => newToken)
        .catch((error: Error) => {
            throw new AuthorizationError(error.message);
        });
}

async function loginWithToken(token: string): Promise<string> {
    const secretKey: any = process.env.JWT_SECRET_KEY;
    const decoded: any = jwt.verify(token, secretKey, { maxAge: '168h' });
    const user: Document = await findUser(decoded.username);
    return assignNewToken(user);
}

function assignNewToken(user: Document): string {
    const secretKey: any = process.env.JWT_SECRET_KEY;
    const payload: object = { username: user.get('username'), iat: Date.now() };
    const newToken: string = jwt.sign(payload, secretKey, { expiresIn: '168h' });
    user.set('token', newToken);
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
    const listOfUsers: Document[] = await retrieveUsers();
    const user: Document | undefined = listOfUsers.find((u: Document) => {
        return u.get('username') === username;
    });

    if (!user) {
        throw new Error('User could not be found.');
    }
    return user;
}

async function retrieveUsers(): Promise<Document[]> {
    return new Promise((resolve: any, reject: any) => {
        UserModel.find({}, (error: any, users: Document[]) => {
            if (error) {
                return reject(error);
            }
            return resolve(users);
        });
    });
}

export { getUser, postUser, getUserAttributes, getUserToken, assignNewToken, createUser, findUser, AVAILABLE_FIELDS };
