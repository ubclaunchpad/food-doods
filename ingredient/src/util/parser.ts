import { IRecipe, IRecipeIngredient, UnitCategory } from '../types/_master-types';

const bracketContentsRegex = /\((.*?)\)/;
const bracketRegex = /[()]/;

const volumeUnits = ['cup', 'teaspoon', 'tablespoon', 'ounce', 'pinch'];
const weightUnits = ['gram', 'pound'];

const volumes = volumeUnits.concat(volumeUnits.map((unit) => unit + 's'));
const weights = weightUnits.concat(weightUnits.map((unit) => unit + 's'));

export function parseRecipe(recipe: IRecipe): IRecipeIngredient[] {
    return recipe.ingredients.map(parse).filter(Boolean);
}

export function parse(ingredient: string): IRecipeIngredient {
    let trimmed = ingredient;
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
}

export function getQuantity(ingredient: string): [number, string] {
    const words = ingredient.split(' ');
    let maybeNum = words[0];
    let cursor = 0;

    // Check for any brackets that start with a number
    const match = bracketContentsRegex.exec(ingredient);
    if (match) {
        const maybePrioritize = match[0].replace(bracketRegex, '');
        const startsWithNumber = !isNaN(parseFloat(maybePrioritize));
        if (maybePrioritize.split(' ').length === 2 && startsWithNumber) {
            maybeNum = maybePrioritize.split(' ')[0];
            cursor = match.index;
        }
    }

    // Check for fractions
    if (maybeNum.includes('/')) {
        const fraction = getFraction(maybeNum);
        if (!fraction) {
            return [null, ingredient];
        }
        cursor += maybeNum.length;
        return [fraction, ingredient.slice(cursor + 1).trimLeft()];
    }

    let quantity = parseFloat(maybeNum);
    if (isNaN(quantity)) {
        return [null, ingredient];
    }
    cursor += maybeNum.length;

    // Check for additional fractions
    const maybeMixed = words[1];
    if (maybeMixed.includes('/')) {
        const fraction = getFraction(maybeMixed);
        if (!fraction) {
            return [null, ingredient];
        }
        quantity += fraction;
        cursor += maybeMixed.length;
    }
    return [quantity, ingredient.slice(cursor + 1).trimLeft()];
}

function getFraction(maybeFraction: string): number {
    const [numer, denom] = maybeFraction.split('/').map(parseFloat);
    if (isNaN(numer) || isNaN(denom)) {
        return null;
    }
    return numer / denom;
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
