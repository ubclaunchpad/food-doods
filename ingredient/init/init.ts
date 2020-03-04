import { readFileSync } from 'fs';
import { resolve } from 'path';

interface IRecipe {
    ingredients?: string[];
}

const seedData = JSON.parse(readFileSync(resolve('init/seed.json')).toString());
const values = Object.values(seedData);

values
    .filter((recipe) => recipe.hasOwnProperty('ingredients'))
    .forEach((recipe: IRecipe) => {
        const { ingredients } = recipe;
        ingredients.forEach((description: string) => {
            const words = description.split(' ');
            console.log(words.slice(2, words.length - 1).join(' '));
        });
    });
