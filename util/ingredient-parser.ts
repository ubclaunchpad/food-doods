interface IRecipe {
    ingredients?: string[];
}

type UnitCategory = 0 | 1 | 2 | 3;

interface IIngredient {
    name: string;
    unit_category: UnitCategory;
}

const pluralfy = (units: string[]) => units.map((unit) => unit + 's');

const volumeUnits = ['cup', 'teaspoon', 'tablespoon', 'ounce'];
const weightUnits = ['gram', 'pound'];

const volumes = volumeUnits.concat(pluralfy(volumeUnits));
const weights = weightUnits.concat(pluralfy(weightUnits));

const matchWordToUnit = (word: string): UnitCategory => {
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
    return name
        .split(',')[0]
        .replace(/\((.*?)\)/, '')
        .trim();
};

const parseIngredient = (description: string): IIngredient => {
    const words = description.split(' ');
    // take out ADVERTISEMENT
    const trimmed = words.slice(0, words.length - 1);
    const unitInfo = getUnit(trimmed);
    if (unitInfo) {
        const { unit, index } = unitInfo;
        return { name: getName(trimmed, index), unit_category: unit };
    }
};

const trim = (ingredients: IIngredient[]) => {
    const uniques = new Set<string>();
    const result: IIngredient[] = [];
    for (const ingredient of ingredients) {
        if (!uniques.has(ingredient.name)) {
            uniques.add(ingredient.name);
            result.push(ingredient);
        }
    }
    return result;
};

export const parse = (data: string[]): IIngredient[] => trim(data.map(parseIngredient).filter(Boolean));
