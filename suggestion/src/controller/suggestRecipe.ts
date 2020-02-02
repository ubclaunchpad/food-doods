import { compareHash } from '../util/compareHash';
import { fetchRecipes } from '../util/fetchRecipes';
import { hashIngredientList } from '../util/hashIngredientList';

const NUM_OF_RECIPES = 5;
const PER_PAGE = 25;

/**
 * Fetches 25 recipes from the DB at a time
 * Compares user's ingredients with the recipe's ingredients
 * Tries to find 5 recipes that exceeds the threshold
 * Repeats the above process until it finds 5 recipes above the threshold
 * @param ingredientIds - An array of ingredientIds of the user
 * @param threshold - A threshold that determines which recipes to return
 * @returns - First 5 recipes (or less than 5 recipes) from the DB that exceeds the threshold
 */

const suggestRecipes = (ingredientIds: number[], threshold: number): number[] => {
    console.log('hello');
    const hashIngredients = parseInt(hashIngredientList(ingredientIds), 2);
    console.log('finished hashList');
    const retRecipes = [];
    let pageCount = 0;
    while (retRecipes.length < NUM_OF_RECIPES) {
        console.log('starting fetch');
        const recipes = fetchRecipes(PER_PAGE, PER_PAGE * pageCount);
        console.log('exited fetch');
        if (recipes.length === 0) {
            break;
        }

        for (const recipe of recipes) {
            if (compareHash(recipe, hashIngredients) >= threshold) {
                retRecipes.push(recipe);
            }
            if (retRecipes.length === NUM_OF_RECIPES) {
                // TODO return recipes instead of Hashes
                return retRecipes;
            }
        }
        pageCount++;
        console.log(pageCount);
    }
    // TODO return recipes instead of Hashes
    return retRecipes;
};

export { suggestRecipes };
