import * as fs from 'fs';
import * as mongoose from 'mongoose';
const recipeScraper = require('recipe-scraper');
import { parse } from '../../../util/ingredient-parser';
import { IRecipe, Recipe, RecipeModel } from '../models/recipes';

const idMap = JSON.parse(fs.readFileSync(`${__dirname}/../../../ingredient/mocks/id_map.json`).toString());

export const recipeScraperUtil = (baseUrl: string, recipeIDs: string[]) => {
    const recipes: Array<Promise<IRecipe>> = [];
    for (const id of recipeIDs) {
        recipes.push(recipeScraper(baseUrl + id));
    }
    Promise.all(recipes).then((data) => saveRecipeToDB(data));
};

const saveRecipeToDB = (recipes: IRecipe[]) => {
    for (const recipe of recipes) {
        console.log(recipe.ingredients);
        const parsed = parse(recipe.ingredients);
        console.log(
            parsed.map((ingr) => {
                return { ...ingr, id: idMap[ingr.name] };
            })
        );
    }
    const recipe = mongoose.model('recipe', Recipe);
    // recipe.collection.insertMany(recipes, onInsert);

    // function onInsert(err, docs) {
    //     if (err) {
    //         console.error(err);
    //     } else {
    //         console.info('%d recipes were successfully stored.', docs.length);
    //     }
    // }
};
