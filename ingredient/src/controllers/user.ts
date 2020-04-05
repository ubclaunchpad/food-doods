import { Request, Response } from 'express';
import { db } from '../db/connection';

export const addUser = async (req: Request, res: Response) => {
    const { externalId } = req.body;
    return db
        .one('INSERT INTO user_map (external_id) VALUES ($1) RETURNING id', [externalId])
        .then(({ id }: { id: number }) => res.status(201).json({ id }))
        .catch((error: Error) => res.status(400).json({ error: error.message }));
};

export const deleteUser = async (req: Request, res: Response) => {
    const { id } = req.params;
    return db
        .one('SELECT * FROM user_map WHERE external_id = $1', [id])
        .then(() => db.none('DELETE FROM user_map WHERE id = $1', [id]))
        .then(() => res.status(200).json({ message: 'Successfully deleted user!' }))
        .catch((error: Error) => res.status(404).json({ error: error.message }));
};
