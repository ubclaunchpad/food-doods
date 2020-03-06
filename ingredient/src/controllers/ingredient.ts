import { Request, Response } from 'express';
import { search } from '../util/api';
import { parseResults } from '../util/parser';

export const searchIngredient = (req: Request, res: Response) => {
    const query = req.query.q;
    return search(query)
        .then(parseResults)
        .then((results) => res.status(200).json({ query, results }))
        .catch((error) => res.status(500).json({ error }));
};
