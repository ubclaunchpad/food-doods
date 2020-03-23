import bcrypt from 'bcrypt';
import { Request, Response } from 'express';
import jwt, { TokenExpiredError } from 'jsonwebtoken';
import { Document } from 'mongoose';
import { assignNewToken, findUser } from '../controllers/user';
import { AuthenticationError } from '../util/errors/AuthenticationError';

const postUserLogin = async (req: Request, res: Response): Promise<Response> => {
    const { username, password } = req.body;
    const token: any = req.header('token');

    return verifyUser(username, password, token)
        .then((newToken: string) => {
            if (newToken) {
                return res
                    .status(200)
                    .set('token', newToken)
                    .send({ message: 'Successfully logged in.' });
            }
            return res.status(401).json({ message: 'Authorization denied.' });
        })
        .catch((error: any) => {
            return res.status(422).json({ error });
        });
};

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

export { postUserLogin, verifyUser };
