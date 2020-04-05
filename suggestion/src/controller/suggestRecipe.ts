import { readFileSync } from 'fs';
import { resolve } from 'path';
import { compareHash } from '../util/compareHash';
import { fetchRecipes } from '../util/fetchRecipes';
import { hashIngredientList } from '../util/hashIngredientList';

const hashes = JSON.parse(readFileSync(resolve('mocks/hashes.json')).toString());

const NUM_OF_RECIPES = 5;
const PER_PAGE = 25;

/**
 * Fetches 25 recipes from the DB at a time
 * Compares user's ingredients with the recipe's ingredients
 * Tries to find 5 recipes that exceeds the threshold
 * Repeats the above process until it finds 5 recipes above the threshold
 * @param ingredientIds - An array of ingredientIds of the user
 * @param allIngredientIds - An array of all ingredientIds in the database
 * @param threshold - A threshold that determines which recipes to return
 * @param source - Search space to look for recipes, defaults to hashes.json
 * @returns - First 5 recipes (or less than 5 recipes) from the DB that exceeds the threshold
 */

const suggestRecipes = (
    ingredientIds: number[],
    allIngredientIds: number[],
    threshold: number,
    source: string[] = hashes
): number[] => {
    const retRecipes = [];
    let pageCount = 0;
    while (retRecipes.length < NUM_OF_RECIPES) {
        const recipes = fetchRecipes(source, PER_PAGE, PER_PAGE * pageCount);
        if (!recipes.length) {
            break;
        }

        const hashIngredients: string = hashIngredientList(ingredientIds, allIngredientIds);
        for (const recipe of recipes) {
            const recipeBitString: string = recipe
                .split('')
                .map((bit: string) => (bit === '1' ? 1 : 0))
                .join('');
            if (compareHash(recipeBitString, hashIngredients) >= threshold) {
                retRecipes.push(recipe);
            }
            if (retRecipes.length === NUM_OF_RECIPES) {
                // TODO: return recipes instead of Hashes
                return retRecipes;
            }
        }
        pageCount++;
    }
    // TODO return recipes instead of Hashes
    return retRecipes;
};

export { suggestRecipes };
