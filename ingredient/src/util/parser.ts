import { IRecipe, IRecipeIngredient, UnitCategory } from '../types/_master-types';

const volumeUnits = ['cup', 'teaspoon', 'tablespoon', 'ounce', 'pinch'];
const weightUnits = ['gram', 'pound'];

const volumes = volumeUnits.concat(volumeUnits.map((unit) => unit + 's'));
const weights = weightUnits.concat(weightUnits.map((unit) => unit + 's'));

export function parse(recipe: IRecipe): IRecipeIngredient[] {
    return recipe.ingredients
        .map((description) => {
            let trimmed = description;
            if (trimmed.endsWith('ADVERTISEMENT')) {
                trimmed = trimmed.slice(0, trimmed.length - 1);
            }
            const quantityInfo = getQuantity(trimmed);
            if (!quantityInfo[0]) {
                return null;
            }
            const [unitCategory, rest] = getUnitCategory(quantityInfo[1]);
            const name = getName(rest);
            const quantity = quantityInfo[0];
            return {
                id: 0,
                quantity,
                name,
                unitCategory,
            };
        })
        .filter(Boolean);
}

export function getQuantity(ingredient: string): [number, string] {
    return [0, ingredient];
}

function getUnitCategory(ingredient: string): [UnitCategory, string] {
    return [0, ingredient];
}

function getName(ingredient: string) {
    return ingredient
        .split(',')[0]
        .replace(/\((.*?)\)/, '')
        .trim();
}

function matchWordToUnit(word: string): UnitCategory {
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
}
