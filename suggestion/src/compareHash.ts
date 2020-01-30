function compareHash(recipeHash: number, ingredientsHash: number): number {
    const numIngredientsInRecipe: number = _countOnes(recipeHash);
    const numIngredientsMatched: number = _countOnes(recipeHash & ingredientsHash);
    return numIngredientsMatched / numIngredientsInRecipe;
}

function _countOnes(bitString: number): number {
    let count: number = 0;
    while (bitString) {
        bitString &= bitString - 1;
        count++;
    }
    return count;
}

export { compareHash };
