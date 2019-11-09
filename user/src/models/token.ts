import jwt from 'jsonwebtoken';
import { Document } from 'mongoose';

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

export { assignNewToken };
