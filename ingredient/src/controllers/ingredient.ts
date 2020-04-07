import { Request, Response } from 'express';
import { db } from '../db/connection';

export const getIngredients = async (req: Request, res: Response) => {
    const { id } = req.params;

    if (id) {
        return db
            .any('SELECT * FROM ingredient WHERE id = $1', [id])
            .then((ingredients: any[]) => res.status(200).json({ ingredients }))
            .catch((error: Error) => res.status(404).json({ error }));
    } else {
        return db
            .any('SELECT id FROM ingredient')
            .then((ingredients: any[]) => res.status(200).json({ ingredients }))
            .catch((error: Error) => res.status(404).json({ error }));
    }
};

export const postIngredient = async (req: Request, res: Response) => {
    const { name, unitCategory } = req.body;

    return db
        .one('INSERT INTO ingredient (name, test_data, unit_category) VALUES ($1, false, $2) RETURNING id', [
            name,
            unitCategory,
        ])
        .then(({ id }: { id: number }) => res.status(201).json({ message: 'Successfully created ingredient!', id }))
        .catch((error: Error) => res.status(400).json({ error }));
};

export const patchIngredient = async (req: Request, res: Response) => {
    const { id } = req.params;
    const { name, unitCategory } = req.body;

    let update: Promise<any>;
    if (name && unitCategory) {
        update = db.none('UPDATE ingredient SET name = $1, unit_category = $2 WHERE id = $3', [name, unitCategory, id]);
    } else if (name) {
        update = db.none('UPDATE ingredient SET name = $1 WHERE id = $2', [name, id]);
    } else if (unitCategory) {
        update = db.none('UPDATE ingredient SET unit_category = $1 WHERE id = $2', [unitCategory, id]);
    } else {
        return res.status(400).json({ error: "Updates are only supported for 'name' and 'unitCategory'." });
    }

    return update
        .then(() => res.status(201).json({ message: 'Updated ingredient successfully!' }))
        .catch((error: Error) => res.status(400).json({ error }));
};

export const deleteIngredient = async (req: Request, res: Response) => {
    const { id } = req.params;

    return db
        .none('DELETE FROM ingredient WHERE id = $1', [id])
        .then(() => res.status(201).json({ message: 'Deleted ingredient successfully!' }))
        .catch((error: Error) => res.status(404).json({ error }));
};
