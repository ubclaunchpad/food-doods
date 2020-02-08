import { readFileSync } from 'fs';
import { resolve } from 'path';

const hashes = JSON.parse(readFileSync(resolve('mocks/hashes.json')).toString());

/**
 * Randomly fetches a list of recipe hashes starting from `startIndex`
 * up to a total of `limit` recipes.
 * @param limit - The maximum number of recipes returned.
 * @param startIndex - The index to start the search.
 * @returns A list of recipe hashes, the length of which is guaranteed to be <= `limit`.
 */
function fetchRecipes(limit: number, startIndex: number = 0) {
    const recipes = new Set();

    if (limit >= hashes.length) {
        return hashes;
    }

    if (startIndex >= hashes.length) {
        return [];
    }

    while (recipes.size < limit) {
        const index = getRandomIndex(startIndex, hashes.length - 1);
        recipes.add(hashes[index]);
    }

    return Array.from(recipes);
}

function getRandomIndex(min: number, max: number) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

export { fetchRecipes };
