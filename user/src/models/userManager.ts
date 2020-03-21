import jwt from 'jsonwebtoken';
import { Document } from 'mongoose';
import { connect } from '.';
import { assignNewToken, findUser } from '../controllers/user';
// import { addUserIngredient } from '../util/ingredient';
// import { addUserRecipe } from '../util/recipe';
import { passwordsMatch } from './password';

async function registerUser(user: Document): Promise<string | false> {
    const callback = async (error: any): Promise<string | false> => {
        if (error) {
            throw error;
        }
        const token: string | false = assignNewToken(user);
        return user
            .save()
            .then(() => {
                // const username: string = user.get('username');
                // return Promise.all([addUserIngredient(username), addUserRecipe(username)]);
                return user.get('username');
            })
            .then(() => {
                return token;
            })
            .catch((err: any) => {
                throw err;
            });
    };
    return await connect(callback);
}

async function verifyUser(username: string, password: string, token: string): Promise<string | false> {
    const user: Document = await findUser(username);
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

export { registerUser, verifyUser };
