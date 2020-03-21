import { readFileSync, writeFile } from 'fs';
import { resolve } from 'path';
import { IIngredient } from '../src/types/_master-types';
import { parse } from '../src/util/parser';

const seedData = JSON.parse(readFileSync(resolve('init/seed.json')).toString());
const values = Object.values(seedData);

const sequelfy = (ingrs: IIngredient[]) => {
    let result = `insert into ingredient (id, name, test_data, unit_category)
    values
    `;
    ingrs.forEach((ingredient, idx) => {
        const id = idx + 1;
        result += `(${idx + 1}, "${ingredient.name}", false, ${ingredient.unit_category})${
            id < ingrs.length ? ',' : ';'
        }\n`;
    });
    return result;
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

const parsed = values.filter((recipe: any) => recipe.hasOwnProperty('ingredients')).flatMap(parse);
const ingredients = trim(parsed);

const script = sequelfy(ingredients);

const idMap = {};
ingredients.forEach((ingr, idx) => (idMap[ingr.name] = idx + 1));

writeFile('init/seed.sql', script, (err) => {
    if (err) {
        console.error(err);
    }
    console.log('Finished writing initialization script');
});

writeFile('mocks/db.json', JSON.stringify(parsed), (err) => {
    if (err) {
        console.error(err);
    }
    console.log('Finished writing mock db');
});

writeFile('mocks/id_map.json', JSON.stringify(idMap), (err) => {
    if (err) {
        console.error(err);
    }
    console.log('Finished writing ID map');
});
