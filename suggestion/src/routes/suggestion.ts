import * as express from 'express';
import { readFileSync } from 'fs';
import { resolve } from 'path';
import { suggestRecipes } from '../controller/suggestRecipe';

const router = express.Router();

// POST /suggestion?ingredients=xyz
router.post('/', (req, res) => {
    const httpBody = req.body;
    const numIngredients = httpBody.queryIngredients.length;

    const testThreshold = 0.5;

    const IDs = [];

    for (let i = 0; i < numIngredients; i++) {
        IDs.push(httpBody.queryIngredients[i].databaseID);
    }

    const recipeHashes = suggestRecipes(IDs, testThreshold);

    // return as a json object with key "hashes"
    res.status(200).json({ hashes: recipeHashes });
});

router.post('/:userId', (req, res) => {
    // get all ingredients
    // const ingredients = GET Ingredients of a User by User Id
    const object = JSON.parse(readFileSync(resolve('mocks/sampleIngredients.json')).toString());
    // hash the ingredients
    // get all the recipes
    // const recipes = GET All the Recipes
    // compare hashed ingredients with recipes
    const recipeNumber = 3;
    const recipes = JSON.parse(readFileSync(resolve('mocks/hashes.json')).toString());
    const suggestedRecipes = suggestRecipes(object.ingredients, recipeNumber, recipes);
    console.log(suggestedRecipes);
    // return recipe id's
});

module.exports = router;
