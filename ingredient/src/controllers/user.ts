import { Request, Response } from 'express';
import { db } from '../db/connection';

let internalId = 0;

export const addUser = (req: Request, res: Response) => {
    const { userId } = req.params;
    return db
        .none(
            `insert into id_map
        values ($1, $2)`,
            [internalId++, userId]
        )
        .then(() => res.status(201).end())
        .catch((error) => res.status(500).json({ error }));
};

export const deleteUser = (req: Request, res: Response) => {
    const { userId } = req.params;
    return db
        .none('delete from id_map where external_id = $1', [userId])
        .then(() => res.status(204).end())
        .catch((error) => res.status(500).json({ error }));
};
