/**
 * Given an array of numbers each representing an ingredient id,
 * this function maps and returns a bitstring representation of the array
 * that describes which ingredients are present from the available ingredient list,
 * ordered from most to least significant bit.
 *
 * @param ingredientList - An array of numbers each representing an ingredient id
 * @param allIngredientIds - An array of numbers each representing an ingredient id, should contain all in db
 * @returns - A bit string representing the ingredients needed for a recipe
 */
function hashIngredientList(ingredientIds: number[], allIngredientIds: number[]): string {
    // sort all the ingredient ids in ascending order so the hashes maintain an order
    // makes retrieval of ids from hashes easier
    const allIngredientIdsSorted: number[] = allIngredientIds.sort();
    const hashArray = Array(allIngredientIds.length).fill(0);

    for (const id of ingredientIds) {
        // places a '1' in the position of the ingredient in the sorted array
        // e.g. allIngredientIdsSorted: [11, 14, 18, 20, 34]
        //      ingredientIds: [14, 18]
        //      returned hash should be: "01100" because 14 and 18 match
        const index = allIngredientIdsSorted.indexOf(id);
        hashArray[index] = 1;
    }

    return hashArray.join('');
}

export { hashIngredientList };
