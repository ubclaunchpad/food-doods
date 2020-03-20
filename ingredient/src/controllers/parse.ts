import { Request, Response } from 'express';
import { db } from '../db/connection';
import { parse as parseRecipe } from '../util/parser';

export const parse = (req: Request, res: Response) => {
    const error = validate(req.body);
    if (error) {
        return res.status(400).send(error);
    }
    const ingredients = parseRecipe(req.body);
    return res.json({ ingredients });
};

const validate = (body: any) => {
    if (!body) {
        return 'Missing recipe.';
    }
    if (!body.ingredients) {
        return 'The given recipe must have an ingredients property.';
    }
    if (!Array.isArray(body.ingredients)) {
        return 'Ingredients must be an array.';
    }
    if (!body.ingredients.every((i: any) => typeof i === 'string')) {
        return 'Each element of ingredients must be a string.';
    }
    return null;
};
