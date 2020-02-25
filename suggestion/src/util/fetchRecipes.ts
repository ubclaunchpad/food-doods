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
    }

    if (startIndex >= source.length) {
        return [];
    }

    while (recipes.size < limit) {
        const index = getRandomIndex(startIndex, source.length - 1);
        recipes.add(source[index]);
    }

    return Array.from(recipes);
}

function getRandomIndex(min: number, max: number) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

export { fetchRecipes };
