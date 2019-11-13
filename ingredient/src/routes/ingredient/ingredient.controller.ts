import { Request, Response } from 'express';
import { db } from '../../db';

export const addIngredient = (req: Request, res: Response) => {
    const { userId } = req.params;
    const { id, quantity, unit } = req.body;

    return db
        .none('insert into stored_ingredient values ($1, $2, $3, $4)', [userId, id, quantity, unit])
        .then(() => res.status(201).end())
        .catch((error) => res.status(500).json({ error }));
};

export const updateIngredient = (req: Request, res: Response) => {
    const { userId } = req.params;
    const { id, quantity } = req.body;

    return getInternalId(userId)
        .then((internalId) =>
            db.none('update stored_ingredient set quantity = $1 where user_id = $2 and ingredient_id = $3', [
                quantity,
                internalId,
                id,
            ])
        )
        .then(() => res.status(204).end())
        .catch((error) => res.status(500).json({ error }));
};

export const deleteIngredient = (req: Request, res: Response) => {
    const { userId } = req.params;
    const { id } = req.body;

    return getInternalId(userId)
        .then((internalId) =>
            db.none('delete from stored_ingredient where user_id = $1 and ingredient_id = $2', [internalId, id])
        )
        .then(() => res.status(204).end())
        .catch((error) => res.status(500).json({ error }));
};

const getInternalId = (externalId: string) =>
    db.one('select internal_id from id_map where external_id = $1', [externalId], (data) => data.internal_id);
