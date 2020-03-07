import { readFileSync } from 'fs';
import { resolve } from 'path';

interface IRecipe {
    ingredients?: string[];
}

const seedData = JSON.parse(readFileSync(resolve('init/seed.json')).toString());
const values = Object.values(seedData);

const pluralfy = (units: string[]) => units.map((unit) => unit + 's');

const volumeUnits = ['cup', 'teaspoon', 'tablespoon', 'ounce'];
const weightUnits = ['gram', 'pound'];

const volumes = volumeUnits.concat(pluralfy(volumeUnits));
const weights = weightUnits.concat(pluralfy(weightUnits));

const matchWordToUnit = (word: string) => {
    const trimmed = word.replace(/[()]/, '');
    if (volumes.includes(trimmed)) {
        return 1;
    }
    if (weights.includes(trimmed)) {
        return 2;
    }
    if (!isNaN(parseInt(trimmed, 2))) {
        return 3;
    }
    return 0;
};

const getUnit = (ingredient: string[]) => {
    for (let index = ingredient.length - 1; index >= 0; index--) {
        const unit = matchWordToUnit(ingredient[index]);
        if (unit) {
            return { unit, index };
        }
    }
    return null;
};

const parseIngredient = (description: string) => {
    const words = description.split(' ');
    // take out ADVERTISEMENT
    const trimmed = words.slice(0, words.length - 1);
    const unitInfo = getUnit(trimmed);
    if (unitInfo) {
        const { unit, index } = unitInfo;
        return { name: trimmed.slice(index + 1).join(' '), unit };
    }
};

const parsedIngredients = values
    .filter((recipe) => recipe.hasOwnProperty('ingredients'))
    .flatMap((recipe: IRecipe) => {
        const { ingredients } = recipe;
        const parsed = [];
        ingredients.forEach((description: string) => {
            const ingr = parseIngredient(description);
            if (ingr) {
                parsed.push(ingr);
            }
        });
        return parsed;
    });

const uniques = new Set();
const result = [];
parsedIngredients.forEach((ingredient) => {
    if (!uniques.has(ingredient.name)) {
        uniques.add(ingredient.name);
        result.push(ingredient);
    }
});
console.log(result.length);
console.log('Example: ', result[0]);
