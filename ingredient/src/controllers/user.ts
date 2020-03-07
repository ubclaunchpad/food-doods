import { Request, Response } from 'express';
import { db } from '../db/connection';

let internalId = 0;

export const addUser = async (req: Request, res: Response) => {
    const { externalId } = req.body;
    return db
        .none('INSERT INTO user_map VALUES ($1, $2)', [internalId++, externalId])
        .then(() => res.status(201).json({ message: 'Successfully added user!' }))
        .catch((error: Error) => res.status(400).json({ error }));
};

export const deleteUser = (req: Request, res: Response) => {
    const { id } = req.params;
    return db
        .none('DELETE FROM user_map WHERE external_id = $1', [id])
        .then(() => res.status(204).json({ message: 'Successfully deleted user!' }))
        .catch((error: Error) => res.status(404).json({ error }));
};
