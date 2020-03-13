import { Request, Response } from 'express';
import { getUserSuggestion } from '../util/suggestion';

const postUserSuggestion = async (req: Request, res: Response): Promise<Response> => {
    const { username } = req.body;

    return getUserSuggestion(username)
        .then((recipes: object[]) => {
            return res.status(200).json({ recipes });
        })
        .catch((error: any) => {
            return res.status(404).json({ error });
        });
};

export { postUserSuggestion };
