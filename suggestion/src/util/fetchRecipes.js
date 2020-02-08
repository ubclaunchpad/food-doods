"use strict";
exports.__esModule = true;
var fs_1 = require("fs");
var path_1 = require("path");
var hashes = fs_1.readFileSync(path_1.resolve('mocks/hashes.json')).toJSON().data;
/**
 * Randomly fetches a list of recipe hashes starting from `startIndex`
 * up to a total of `limit` recipes.
 * @param limit - The maximum number of recipes returned.
 * @param startIndex - The index to start the search.
 * @returns A list of recipe hashes, the length of which is guaranteed to be <= `limit`.
 */
function fetchRecipes(limit, startIndex) {
    if (startIndex === void 0) { startIndex = 0; }
    var recipes = [];
    var seen = new Set();
    while (recipes.length < limit && seen.size <= hashes.length) {
        var index = getRandomIndex(startIndex, hashes.length - 1);
        var nextHash = hashes[index];
        while (seen.has(nextHash) && seen.size <= hashes.length) {
            var nextIndex = getRandomIndex(startIndex, hashes.length - 1);
            nextHash = hashes[nextIndex];
        }
        recipes.push(nextHash);
        seen.add(nextHash);
    }
    return recipes;
}
exports.fetchRecipes = fetchRecipes;
function getRandomIndex(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
