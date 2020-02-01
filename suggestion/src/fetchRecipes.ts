import hashes from '../mocks/recipes'; // Change this data source to an API call

/**
 * Randomly fetches a list of recipe hashes starting from `startIndex`
 * up to a total of `limit` recipes.
 * @param limit - The maximum number of recipes returned.
 * @param startIndex - The index to start the search. Guarantees that the index of all hashes returned is greater than this index.
 * @returns A list of recipe hashes, the length of which is guaranteed to be <= `limit`.
 */
function fetchRecipes(limit: number, startIndex: number = 0) {
    const recipes = [];
    const seen = new Set();

    while (recipes.length < limit && seen.size <= hashes.length) {
        const index = getRandomIndex(startIndex, hashes.length - 1);
        let nextHash = hashes[index];
        while (seen.has(nextHash) && seen.size <= hashes.length) {
            const nextIndex = getRandomIndex(startIndex, hashes.length - 1);
            nextHash = hashes[nextIndex];
        }
        recipes.push(nextHash);
        seen.add(nextHash);
    }

    return recipes;
}

function getRandomIndex(min: number, max: number) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

export { fetchRecipes };
