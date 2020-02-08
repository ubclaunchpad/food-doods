"use strict";
exports.__esModule = true;
/**
 * Given an array of numbers each representing an ingredient id,
 * this function maps and returns a bitstring representation of the array
 * that describes which ingredients are present from the available ingredient list,
 * ordered from most to least significant bit.
 *
 * @param ingredientList - An array of numbers each representing an ingredient id
 * @returns - A bit string representing the ingredients needed for a recipe
 */
function hashIngredientList(ingredientList) {
    var recipeLength = Math.max.apply(Math, ingredientList);
    var tempArr = Array(recipeLength + 1).fill(0);
    for (var _i = 0, ingredientList_1 = ingredientList; _i < ingredientList_1.length; _i++) {
        var ingredient = ingredientList_1[_i];
        tempArr[recipeLength - ingredient] = 1;
    }
    return tempArr.join('');
}
exports.hashIngredientList = hashIngredientList;
