import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { Document, model, Model, Schema, Types } from 'mongoose';
import { createLocation, getLocationID, locationIsValid } from './location';

const SALT_ROUNDS: number = 10;

const UserModel: Model<Document> = model(
    'User',
    new Schema({
        email: { type: String, required: true, unique: true, dropDups: true },
        username: { type: String, required: true, unique: true, dropDups: true },
        password: { type: String, required: true },
        fullName: { type: String, required: true },
        timeCreated: { type: Date, required: true, default: new Date() },
        dateOfBirth: { type: Date },
        location: { type: { type: Types.ObjectId, ref: 'Location' } },
        token: { type: String },
    })
);

async function createUser(user: any): Promise<Document> {
    const { email, username, password, fullName, dateOfBirth, location } = user;
    const newUser: Document = new UserModel({
        email,
        username,
        password: hashPassword(password),
        fullName,
        timeCreated: Date.now(),
        dateOfBirth,
        token: null,
    });

    return new Promise((resolve, reject) => {
        if (locationIsValid(location)) {
            createLocation(location)
                .then(() => {
                    return getLocationID(location);
                })
                .then((locationId: Types.ObjectId) => {
                    newUser.set('location', locationId);
                    return newUser.save();
                })
                .then((userWithLocation: Document) => {
                    resolve(userWithLocation);
                })
                .catch((err: any) => {
                    reject(err);
                });
        } else {
            resolve(newUser);
        }
    });
}

function hashPassword(password: string): string {
    return bcrypt.hashSync(password, SALT_ROUNDS);
}

async function passwordsMatch(user: Document, password: string): Promise<boolean> {
    return bcrypt.compare(password, user.get('password'));
}

function assignNewToken(user: Document): string {
    const newToken: string = generateToken(user);
    user.set('token', newToken);
    return newToken;
}

function generateToken(user: Document): string {
    let token: string = '';

    const secretKey: string | undefined = process.env.JWT_SECRET_KEY;
    const payload: object = { username: user.get('username'), iat: Date.now() };

    if (secretKey) {
        token = jwt.sign(payload, secretKey, { expiresIn: '168h' });
    } else {
        throw new Error('Secret key is not defined.');
    }

    return token;
}

export { createUser, hashPassword, passwordsMatch, assignNewToken };
