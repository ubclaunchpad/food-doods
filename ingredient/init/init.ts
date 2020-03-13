import { readFileSync, writeFile } from 'fs';
import { resolve } from 'path';
import { parse } from '../../util/ingredient-parser';

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
    .filter((recipe) => recipe.hasOwnProperty('ingredients'))
    .flatMap((recipe: any) => parse(recipe.ingredients));

const script = sequelfy(parsed);

writeFile('init/seed.sql', script, (err) => {
    if (err) {
        console.error(err);
    }
    console.log('Done!');
});
