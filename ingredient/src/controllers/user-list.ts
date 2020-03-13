import { Request, Response } from 'express';
import { db } from '../db/connection';

export const getIngredients = (req: Request, res: Response): Promise<Response> => {
    const { id: userId } = req.params;

    return db
        .any(
            'SELECT * \
            FROM user_ingredient \
            INNER JOIN ingredient ON user_ingredient.ingredient_id=ingredient.id \
            WHERE user_id = $1',
            [userId]
        )
        .then((ingredients: any[]) => res.status(200).json({ userId, ingredients }))
        .catch((error: Error) => res.status(404).json({ error }));
};

export const addIngredient = (req: Request, res: Response): Promise<Response> => {
    const { id: userId } = req.params;
    const { id, quantity } = req.body;

    return db
        .none('INSERT INTO user_ingredient VALUES ($1, $2, $3)', [userId, id, quantity])
        .then(() => res.status(201).json({ message: "Successfully added ingredient to user's list!" }))
        .catch((error: Error) => res.status(500).json({ error }));
};

export const updateIngredient = (req: Request, res: Response): Promise<Response> => {
    const { id: userId } = req.params;
    const { id, quantity } = req.body;

    return db
        .none(
            'UPDATE user_ingredient \
            SET quantity = $1 \
            WHERE user_id = $2 AND ingredient_id = $3',
            [quantity, userId, id]
        )
        .then(() => res.status(204).json({ message: 'Successfully updated ingredient quantity!' }))
        .catch((error: Error) => res.status(500).json({ error }));
};

export const deleteIngredient = (req: Request, res: Response): Promise<Response> => {
    const { id: userId } = req.params;
    const { id } = req.body;

    return db
        .none('DELETE FROM user_ingredient WHERE user_id = $1 AND ingredient_id = $2', [userId, id])
        .then(() => res.status(204).json({ message: "Successfully deleted ingredient from user's list" }))
        .catch((error) => res.status(404).json({ error }));
};
