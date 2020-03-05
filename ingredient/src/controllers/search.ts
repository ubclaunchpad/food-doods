import { Request, Response } from 'express';

export const searchIngredient = (req: Request, res: Response) => {
    // query: ingredient in database by name
    const query = req.query.query;

    if (!query) {
        return res.status(400).send({
            error: 'no query was provided',
        });
    }

    return res.send('stub');
};
