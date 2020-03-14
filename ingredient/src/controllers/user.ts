import { Request, Response } from 'express';
import { db } from '../db/connection';

export const addUser = async (req: Request, res: Response) => {
    const { externalId } = req.body;
    return db
        .one('INSERT INTO user_map (external_id) VALUES ($1) RETURNING id', [externalId])
        .then(({ id }: { id: number }) => res.status(201).json({ id }))
        .catch((error: Error) => res.status(400).json({ error }));
};

export const deleteUser = async (req: Request, res: Response) => {
    const { id } = req.params;
    return db
        .any('SELECT * FROM user_map WHERE id = $1', [id])
        .then((user) => {
            if (user.length > 0) {
                return db.none('DELETE FROM user_map WHERE id = $1', [id]);
            } else {
                throw new Error('User does not exist in database');
            }
        })
        .then(() => res.status(200).json({ message: 'Successfully deleted user!' }))
        .catch((error: Error) => res.status(404).send({ error: error.message }));
};
