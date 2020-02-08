"use strict";
exports.__esModule = true;
var compareHash_1 = require("../util/compareHash");
var fetchRecipes_1 = require("../util/fetchRecipes");
var hashIngredientList_1 = require("../util/hashIngredientList");
var NUM_OF_RECIPES = 5;
var PER_PAGE = 25;
/**
 * Fetches 25 recipes from the DB at a time
 * Compares user's ingredients with the recipe's ingredients
 * Tries to find 5 recipes that exceeds the threshold
 * Repeats the above process until it finds 5 recipes above the threshold
 * @param ingredientIds - An array of ingredientIds of the user
 * @param threshold - A threshold that determines which recipes to return
 * @returns - First 5 recipes (or less than 5 recipes) from the DB that exceeds the threshold
 */
var suggestRecipes = function (ingredientIds, threshold) {
    console.log('hello');
    var hashIngredients = parseInt(hashIngredientList_1.hashIngredientList(ingredientIds), 2);
    console.log('finished hashList');
    var retRecipes = [];
    var pageCount = 0;
    while (retRecipes.length < NUM_OF_RECIPES) {
        console.log('starting fetch');
        var recipes = fetchRecipes_1.fetchRecipes(PER_PAGE, PER_PAGE * pageCount);
        console.log('exited fetch');
        if (recipes.length === 0) {
            break;
        }
        for (var _i = 0, recipes_1 = recipes; _i < recipes_1.length; _i++) {
            var recipe = recipes_1[_i];
            if (compareHash_1.compareHash(recipe, hashIngredients) >= threshold) {
                retRecipes.push(recipe);
            }
            if (retRecipes.length === NUM_OF_RECIPES) {
                // TODO return recipes instead of Hashes
                return retRecipes;
            }
        }
        pageCount++;
        console.log(pageCount);
    }
    // TODO return recipes instead of Hashes
    return retRecipes;
};
exports.suggestRecipes = suggestRecipes;
