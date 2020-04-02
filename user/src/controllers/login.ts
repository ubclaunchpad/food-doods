import { Request, Response } from 'express';
import { verifyUser } from '../util/user';

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

export { postUserLogin };
