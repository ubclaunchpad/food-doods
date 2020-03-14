import { IRecipe, IRecipeIngredient, UnitCategory } from '../types/_master-types';

const volumeUnits = ['cup', 'teaspoon', 'tablespoon', 'ounce'];
const weightUnits = ['gram', 'pound'];

const volumes = volumeUnits.concat(pluralfy(volumeUnits));
const weights = weightUnits.concat(pluralfy(weightUnits));

export function parse(recipe: IRecipe): IRecipeIngredient[] {
    return recipe.ingredients
        .map((description) => {
            let trimmed = description;
            if (trimmed.endsWith('ADVERTISEMENT')) {
                trimmed = trimmed.slice(0, trimmed.length - 1);
            }
            const unitInfo = getUnit(trimmed);
            if (unitInfo) {
                const { unit: unitCategory, index } = unitInfo;
                // TODO: Update parser to retrieve quantity info
                return { id: 0, quantity: 0, name: getName(trimmed, index), unitCategory };
            }
            return null;
        })
        .filter(Boolean);
}

function pluralfy(units: string[]) {
    return units.map((unit) => unit + 's');
}

function getName(ingredient: string, index: number) {
    const name = ingredient.slice(index + 1);
    return name
        .split(',')[0]
        .replace(/\((.*?)\)/, '')
        .trim();
}

function getUnit(ingredient: string) {
    for (let index = ingredient.length - 1; index >= 0; index--) {
        const unit = matchWordToUnit(ingredient[index]);
        if (unit) {
            return { unit, index };
        }
    }
    return null;
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
