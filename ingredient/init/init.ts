import { readFileSync, writeFile } from 'fs';
import { resolve } from 'path';
import { db } from '../src/db/connection';
import { IIngredient } from '../src/types/_master-types';
import { parseRecipe } from '../src/util/parser';

const seedData = JSON.parse(readFileSync(resolve('init/seed.json')).toString());
const values = Object.values(seedData);

const sequelfy = (ingrs: IIngredient[]) => {
    ingrs.forEach((ingredient, idx) => {
        if (ingredient.name.length) {
            db.none('insert into ingredient (name, test_data, unit_category) values ($1, $2, $3)', [
                ingredient.name,
                false,
                ingredient.unit_category,
            ]);
        }
    });
};

const trim = (ingrs: IIngredient[]) => {
    const uniques = new Set<string>();
    const result: IIngredient[] = [];
    for (const ingredient of ingrs) {
        if (!uniques.has(ingredient.name)) {
            uniques.add(ingredient.name);
            result.push(ingredient);
        }
    }
    return result;
};

const parsed = values.filter((recipe: any) => recipe.hasOwnProperty('ingredients')).flatMap(parseRecipe);
const ingredients = trim(parsed);

sequelfy(ingredients);
