/**
 * Given an array of numbers each representing an ingredient id,
 * this function maps and returns a bitstring representation of the array
 * that describes which ingredients are present from the available ingredient list,
 * ordered from most to least significant bit.
 *
 * @param ingredientList - An array of numbers each representing an ingredient id
 * @returns - A bit string representing the ingredients needed for a recipe
 */
function hashIngredientList(ingredientList: number[]): string {
    const recipeLength: number = ingredientList.length ? Math.max(...ingredientList) : 0;
    if (recipeLength === 0) {
        return '';
    }
    const tempArr = Array(recipeLength + 1).fill(0);

    for (const ingredient of ingredientList) {
        if (ingredient >= 0) {
            tempArr[recipeLength - ingredient] = 1;
        }
    }

    return tempArr.join('');
}

export { hashIngredientList };
