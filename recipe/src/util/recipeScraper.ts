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

const saveRecipeToDB = (recipes: any) => {
    for (const recipe of recipes) {
        const parsed = parse(recipe.ingredients);
        const ingredients = parsed.map((ingr) => {
            return { ...ingr, id: idMap[ingr.name] };
        });
        recipe.ingredients = ingredients;
    }

    // RecipeModel.bulkInsert(recipes, function(err: any, results: any) {
    //     if (err) {
    //         console.log(err);
    //         process.exit(1);
    //     } else {
    //         console.log(results);
    //         process.exit(0);
    //     }
    // });
};
