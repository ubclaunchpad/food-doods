import { Document, model, Model, Schema, Types } from 'mongoose';
import { createLocation, getLocationID, locationIsValid } from './location';
import { hashPassword } from './password';

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

export { createUser };
