import { readFileSync, writeFile } from 'fs';
import { resolve } from 'path';
import { IRecipe, parse } from '../../util/ingredient-parser';

const seedData = JSON.parse(readFileSync(resolve('init/seed.json')).toString());
const values = Object.values(seedData);

const sequelfy = (ingredients: any[]) => {
    let result = `insert into ingredient (id, name, test_data, unit_category)
    values
    `;
    ingredients.forEach((ingredient, idx) => {
        const id = idx + 1;
        result += `(${idx + 1}, "${ingredient.name}", false, ${ingredient.unit_category})${
            id < ingredients.length ? ',' : ';'
        }\n`;
    });
    return result;
};

const parsed = values
    .filter((recipe: any) => recipe.hasOwnProperty('ingredients'))
    .flatMap((recipe: IRecipe) => parse(recipe.ingredients));

const script = sequelfy(parsed);

const idMap = {};
parsed.forEach((ingr, idx) => (idMap[ingr.name] = idx));

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
