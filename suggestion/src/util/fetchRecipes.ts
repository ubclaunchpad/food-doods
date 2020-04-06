/**
 * Randomly fetches a list of recipe hashes starting from `startIndex`
 * up to a total of `limit` recipes.
 * @param source - The search space
 * @param limit - The maximum number of recipes returned.
 * @param startIndex - The index to start the search.
 * @returns A list of recipe hashes, the length of which is guaranteed to be <= `limit`.
 */
function fetchRecipes(source: string[], limit: number, startIndex: number = 0): string[] {
    const recipes = new Set<string>();

    if (limit >= source.length) {
        return source;
    } else if (source.length - startIndex <= limit) {
        return source.slice(startIndex);
    }

    if (startIndex >= source.length) {
        return [];
    }

    let iteration = 0;
    // the number '2' here is arbitrary
    // the second condition means to stop the while loop after
    // going through the source[min, max] 2x because this probably means
    // that you added all the recipes in this range already
    while (recipes.size < limit && iteration < limit * 2) {
        const index = getRandomIndex(startIndex, source.length - 1);
        recipes.add(source[index]);
        iteration++;
    }

    return Array.from(recipes);
}

function getRandomIndex(min: number, max: number) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

export { fetchRecipes };
