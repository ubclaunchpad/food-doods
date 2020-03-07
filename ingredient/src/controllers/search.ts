import { Request, Response } from 'express';
import { db } from '../db/connection';

export const searchIngredient = (req: Request, res: Response) => {
    // query: ingredient in database by name
    const query = req.query.query;

    if (!query) {
        return res.status(400).send({
            error: 'no query was provided',
        });
    }

    return db
        .any('SELECT * FROM ingredient WHERE LOWER(name) LIKE LOWER(%$1%)', [query])
        .then((ingredients: any[]) => {
            if (ingredients.length > 0) {
                return res.status(200).json({ ingredients });
            } else {
                return res.status(404).json({ error: 'No matching ingredients were found' });
            }
        })
        .catch((error: any) => {
            return res.status(500).json({ error });
        });
};
