import { Request, Response } from 'express';
import { db } from '../db/connection';
import { parseRecipe } from '../util/parser';

export const parse = async (req: Request, res: Response) => {
    const error = validate(req.body);
    if (error) {
        return res.status(400).json({ error });
    }
    try {
        const ingredients = parseRecipe(req.body);
        const result = [];
        for (const ingredient of ingredients) {
            const data = await db.oneOrNone('select id from ingredient where name = $1', ingredient.name);
            if (data) {
                result.push({ ...ingredient, id: data.id });
            } else {
                const { id } = await db.one(
                    'insert into ingredient(name, test_data, unit_category) values ($1, $2, $3) returning id',
                    [ingredient.name, false, ingredient.unit_category]
                );
                result.push({ ...ingredient, id });
            }
        }
        return res.json({ ingredients: result });
    } catch (error) {
        return res.status(500).json({ error });
    }
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
