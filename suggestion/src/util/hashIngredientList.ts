/**
 * Given an array of numbers each representing an ingredient id,
 * this function maps and returns a bitstring representation of the array
 * that describes which ingredients are present from the available ingredient list,
 * ordered from most to least significant bit.
 *
 * @param ingredientList - An array of numbers each representing an ingredient id
 * @returns - A bit string representing the ingredients needed for a recipe
 */
function hashIngredientList(recipeHash: number[]): string {
    const recipeLength: number = Math.max(...recipeHash);
    const tempArr: number[] = Array(recipeLength + 1).fill(0);

    // tslint:disable-next-line:prefer-for-of
    for (let i = 0; i < recipeHash.length; i++) {
        tempArr[recipeLength - recipeHash[i]] = 1;
    }

    return tempArr.join('');
}

export { hashIngredientList };
