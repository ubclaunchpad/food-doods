import jwt from 'jsonwebtoken';
import { Document } from 'mongoose';
import { connect } from '.';
import { passwordsMatch } from './password';
import { assignNewToken } from './user';

const listOfUsers: Document[] = [];

function findUser(username: string): Document {
    const user: Document | undefined = listOfUsers.find((u: Document) => {
        return u.get('username') === username;
    });

    if (user) {
        return user;
    } else {
        throw new Error('User could not be found.');
    }
}

async function registerUser(user: Document): Promise<string> {
    const callback = async (err: any): Promise<string> => {
        if (err) {
            throw err;
        }

        const token: string = assignNewToken(user);

        listOfUsers.push(user);
        return user
            .save()
            .then(() => {
                return token;
            })
            .catch((error: any) => {
                throw error;
            });
    };
    return await connect(callback);
}

async function verifyUser(username: string, password: string, token: string): Promise<string | false> {
    const user: Document = findUser(username);
    const match: boolean = await passwordsMatch(user, password);
    const secretKey: any = process.env.JWT_SECRET_KEY;

    if (secretKey) {
        try {
            const decoded: any = jwt.verify(token, secretKey, { maxAge: '168h' });
            if (decoded.username === username && match) {
                return assignNewToken(user);
            }
        } catch (err) {
            switch (err.name) {
                case 'TokenExpiredError':
                    if (match) {
                        return assignNewToken(user);
                    }
                default:
                    throw err;
            }
        }
        return false;
    } else {
        throw new Error('Secret key is not defined.');
    }
}

async function loginWithToken(token: string) {
    const secretKey: any = process.env.JWT_SECRET_KEY;
    const decoded: any = jwt.verify(token, secretKey, { maxAge: '168h' });

    if (decoded) {
        const user: Document = findUser(decoded);
        if (user && decoded.username === user.get('username')) {
            return assignNewToken(user);
        }
    }
    return false;
}

export { registerUser, findUser, verifyUser, loginWithToken };
