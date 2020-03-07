import { readFileSync, writeFile } from 'fs';
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

const getName = (ingredient: string[], index: number) => {
    const name = ingredient.slice(index + 1).join(' ');
    return name.split(',')[0].replace(/\((.*?)\)/, '');
};

const parseIngredient = (description: string) => {
    const words = description.split(' ');
    // take out ADVERTISEMENT
    const trimmed = words.slice(0, words.length - 1);
    const unitInfo = getUnit(trimmed);
    if (unitInfo) {
        const { unit, index } = unitInfo;
        return { name: getName(trimmed, index), unit };
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

let script = `
    insert into ingredient
        (id, name, test_data, unit_category)
    values
`;
result.forEach((ingredient, idx) => {
    const id = idx + 1;
    script += `\t\t(${idx + 1}, "${ingredient.name}", false, ${ingredient.unit})${id < result.length ? ',' : ';'}\n`;
});
writeFile('init/seed.sql', script, (err) => {
    if (err) {
        console.error(err);
    }
    console.log('Done!');
});
