"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
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
exports.suggestRecipes = function (ingredientIds, threshold) { return __awaiter(void 0, void 0, void 0, function () {
    var hashIngredients, retRecipes, pageCount, recipes, _i, recipes_1, recipe;
    return __generator(this, function (_a) {
        hashIngredients = parseInt(hashIngredientList_1.hashIngredientList(ingredientIds), 2);
        retRecipes = [];
        pageCount = 0;
        while (retRecipes.length < NUM_OF_RECIPES) {
            recipes = fetchRecipes_1.fetchRecipes(PER_PAGE, PER_PAGE * pageCount);
            if (recipes.length === 0) {
                break;
            }
            for (_i = 0, recipes_1 = recipes; _i < recipes_1.length; _i++) {
                recipe = recipes_1[_i];
                if (compareHash_1.compareHash(recipe, hashIngredients) >= threshold) {
                    retRecipes.push(recipe);
                }
                if (retRecipes.length === NUM_OF_RECIPES) {
                    // TODO return recipes instead of Hashes
                    return [2 /*return*/, retRecipes];
                }
            }
            pageCount++;
        }
        // TODO return recipes instead of Hashes
        return [2 /*return*/, retRecipes];
    });
}); };
