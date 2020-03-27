import jwt from 'jsonwebtoken';
import { Document } from 'mongoose';
import { findUser } from './user';

const JWT_SECRET_KEY: string | undefined = process.env.JWT_SECRET_KEY;

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

export { assignNewToken, getUserToken };
