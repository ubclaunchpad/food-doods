export function hashIngredientList(recipeHash: number[]): string {
    const recipeLength: number = Math.max(...recipeHash);
    const tempArr: number[] = Array(recipeLength + 1).fill(0);

    // tslint:disable-next-line:prefer-for-of
    for (let i = 0; i < recipeHash.length; i++) {
        tempArr[recipeLength - recipeHash[i]] = 1;
    }

    return tempArr.join('');
}
