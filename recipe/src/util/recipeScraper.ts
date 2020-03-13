import * as mongoose from 'mongoose';
const recipeScraper = require('recipe-scraper');
import { IRecipe, Recipe, RecipeModel } from '../models/recipes';

export const recipeScraperUtil = (baseUrl: string, recipeIDs: string[]) => {
    const recipes: Array<Promise<IRecipe>> = [];
    for (const id of recipeIDs) {
        recipes.push(recipeScraper(baseUrl + id));
    }
    Promise.all(recipes).then((data) => saveRecipeToDB(data));
};

const saveRecipeToDB = (recipes: IRecipe[]) => {
    const recipe = mongoose.model('recipe', Recipe);
    recipe.collection.insertMany(recipes, onInsert);

    function onInsert(err, docs) {
        if (err) {
            console.error(err);
        } else {
            console.info('%d recipes were successfully stored.', docs.length);
        }
    }
};