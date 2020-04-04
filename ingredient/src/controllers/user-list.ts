import { Request, Response } from 'express';
import { db } from '../db/connection';

export const getIngredients = async (req: Request, res: Response): Promise<any> => {
    const { id } = req.params;

    return db
        .one('SELECT * FROM user_map WHERE external_id = $1', [id])
        .then((user: any) =>
            db.any(
                'SELECT I.id as id, I.name as name, UI.quantity as quantity, U.name as unit \
                FROM user_ingredient UI \
                INNER JOIN ingredient I ON UI.ingredient_id=I.id \
                INNER JOIN unit_category U ON I.unit_category=U.id \
                WHERE UI.user_id = $1',
                [user.id]
            )
        )
        .then((ingredients: any[]) => res.status(200).json({ id, ingredients }))
        .catch(() => res.status(404).json({ error: `No users found with the id: ${id}` }));
};

export const addIngredient = async (req: Request, res: Response): Promise<Response> => {
    const { id: userId } = req.params;
    const { id, quantity } = req.body;

    return db
        .one('SELECT * FROM user_map WHERE external_id = $1', [userId])
        .then((user: any) => db.none('INSERT INTO user_ingredient VALUES ($1, $2, $3)', [user.id, id, quantity]))
        .then(() => res.status(201).json({ message: "Successfully added ingredient to user's list!" }))
        .catch((error: Error) => res.status(500).json({ error }));
};

export const updateIngredient = async (req: Request, res: Response): Promise<Response> => {
    const { id: userId } = req.params;
    const { id, quantity } = req.body;

    return db
        .one('SELECT * FROM user_map WHERE external_id = $1', [userId])
        .then((user: any) =>
            db.none(
                'UPDATE user_ingredient \
                SET quantity = $1 \
                WHERE user_id = $2 AND ingredient_id = $3',
                [quantity, user.id, id]
            )
        )
        .then(() => res.status(204).json({ message: 'Successfully updated ingredient quantity!' }))
        .catch((error: Error) => res.status(500).json({ error }));
};

export const deleteIngredient = async (req: Request, res: Response): Promise<Response> => {
    const { id: userId } = req.params;
    const { id } = req.body;

    return db
        .one('SELECT * FROM user_map WHERE external_id = $1', [userId])
        .then((user: any) =>
            db.none('DELETE FROM user_ingredient WHERE user_id = $1 AND ingredient_id = $2', [user.id, id])
        )
        .then(() => res.status(204).json({ message: "Successfully deleted ingredient from user's list" }))
        .catch((error) => res.status(404).json({ error }));
};
