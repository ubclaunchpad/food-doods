import bcrypt from 'bcrypt';
import jwt, { TokenExpiredError } from 'jsonwebtoken';
import { Document } from 'mongoose';
import { connect } from '../db/index';
import { UserModel } from '../models/user';
import { AuthenticationError } from './errors/AuthenticationError';
import { AuthorizationError } from './errors/AuthorizationError';
import { addUserIngredient } from './ingredient';
import { createLocation } from './location';
import { addUserRecipe } from './recipe';
import { assignNewToken } from './token';

const AVAILABLE_FIELDS: string[] = ['fullName', 'username', '_id'];
const REQUIRED_LOCATION_FIELDS: string[] = ['city', 'province', 'country'];

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

async function findUser(username: string): Promise<Document> {
    return connect()
        .then(() => UserModel.findOne({ username }))
        .then((user: Document | null) => {
            if (!user) {
                throw new AuthorizationError('User could not be found.');
            }
            return user;
        })
        .catch((err: Error) => {
            throw err;
        });
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

async function removeUser(username: string): Promise<Document> {
    const deletedUser: Document | null = await UserModel.findOneAndDelete({ username });
    if (!deletedUser) {
        throw new Error('User could not be found.');
    }
    return deletedUser;
}

async function registerUser(user: Document): Promise<string> {
    return connect()
        .then(() => {
            const userId: string = user.get('_id');
            return Promise.all([addUserIngredient(userId), addUserRecipe(userId)]);
        })
        .then(() => assignNewToken(user))
        .catch((error: Error) => {
            throw error;
        });
}

async function verifyUser(username: string, password: string, token: string): Promise<string> {
    const user: Document = await findUser(username);
    const match: boolean = await bcrypt.compare(password, user.get('password'));

    try {
        const decoded: any = jwt.verify(token, process.env.JWT_SECRET_KEY as string, { maxAge: '168h' });
        if (decoded.username === username && match) {
            return assignNewToken(user);
        }
    } catch (error) {
        if (error instanceof TokenExpiredError) {
            if (match) {
                return assignNewToken(user);
            }
        }
        throw error;
    }
    throw new AuthenticationError('User could not be authenticated.');
}

export { AVAILABLE_FIELDS, createUser, findUser, getUserAttributes, removeUser, registerUser, verifyUser };
