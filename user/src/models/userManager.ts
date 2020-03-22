import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { Document } from 'mongoose';
import { assignNewToken, findUser } from '../controllers/user';
// import { addUserIngredient } from '../util/ingredient';
// import { addUserRecipe } from '../util/recipe';

async function verifyUser(username: string, password: string, token: string): Promise<string | false> {
    const user: Document = await findUser(username);
    const match: boolean = await bcrypt.compare(password, user.get('password'));
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

export { verifyUser };
