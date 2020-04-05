/**
 * Given a bit string representing the ingredients needed for a recipe
 * and a bit string representing the ingredients a user currently has,
 * this function computes and returns a standardized `similarity score`
 * (i.e., between 0 and 1) that describes how strongly this recipe
 * should be recommended to the given user.
 *
 * @param recipeHash - A bit string representing the ingredients needed for a recipe
 * @param ingredientsHash - A bit string representing the ingredients a user has
 * @returns - A decimal number between 0 and 1 representing what percentage of ingredients
 *            in the recipe the user currently has.
 */
function compareHash(recipeHash: string, ingredientsHash: string): number {
    let commonIngredients: string = '';
    let i: number = 0;
    while (i < recipeHash.length && i < ingredientsHash.length) {
        if (recipeHash[i] === '1' && ingredientsHash[i] === '1') {
            commonIngredients += 1;
        } else {
            commonIngredients += 0;
        }
        i++;
    }
    const numIngredientsMatched: number = _countOnes(commonIngredients);
    const numIngredientsInRecipe: number = _countOnes(recipeHash);
    return !numIngredientsInRecipe ? 0 : Number((numIngredientsMatched / numIngredientsInRecipe).toFixed(5));
}

/**
 * Counts the number of set bits (1s) in the given bit string.
 *
 * @param bitString - A hexadecimal or binary number bit string
 * @returns - The number of 1s in the given bit string.
 */
function _countOnes(bitString: string): number {
    let count: number = 0;
    let i: number = 0;
    while (i < bitString.length) {
        if (bitString[i] === '1') {
            count++;
        }
        i++;
    }
    return count;
}

export { compareHash };
