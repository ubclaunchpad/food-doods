import { Request, Response } from 'express';
import { db } from '../../db';

export const addIngredient = (req: Request, res: Response) => {
    const { userId } = req.params;
    const { ingredientId } = req.body;

    return db
        .none(
            `insert into stored_ingredient
        values ($1, $2)`,
            [userId, ingredientId]
        )
        .then(() => res.status(201).end())
        .catch((error) => res.status(500).json({ error }));
};
