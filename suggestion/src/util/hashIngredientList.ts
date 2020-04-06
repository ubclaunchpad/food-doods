/**
 * Given an array of numbers each representing an ingredient id,
 * this function maps and returns a bitstring representation of the array
 * that describes which ingredients are present from thex available ingredient list,
 * ordered from most to least significant bit.
 *
 * @param ingredientIds - An array of numbers each representing an ingredient id
 * @param allIngredientIds - An array of numbers each representing an ingredient id, should contain all in db
 * @returns - A bit string representing the ingredients needed for a recipe
 */
function hashIngredientList(ingredientIds: number[], allIngredientIds: number[]): string {
    // sort all the ingredient ids in ascending order so the hashes maintain an order
    // makes retrieval of ids from hashes easier
    const allIngredientIdsSorted: number[] = allIngredientIds.sort();
    const hashArray = Array(allIngredientIds.length + 1).fill(0);
    const length = hashArray.length;

    for (const id of ingredientIds) {
        // places a '1' in the position of the ingredient in the sorted array
        // e.g. allIngredientIdsSorted: [1, 2, 3, 4, 5]
        //      ingredientIds: [1, 3]
        //      returned hash should be: "001010" because 1 and 3 match
        const index = allIngredientIdsSorted.indexOf(id);
        hashArray[length - index - 1] = 1;
    }

    return hashArray.join('');
}

export { hashIngredientList };
