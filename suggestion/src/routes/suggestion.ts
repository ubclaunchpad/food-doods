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

// POST /suggestion/:userId
router.post('/:userId', (req, res) => {
    // get all ingredients
    // const ingredients = GET Ingredients of a User by User Id; currently mocked
    const object = JSON.parse(readFileSync(resolve('mocks/sampleIngredients.json')).toString());
    // const recipes = GET All the Recipes; currently mocked
    const recipes = JSON.parse(readFileSync(resolve('mocks/hashes.json')).toString());
    const recipeNumber = 0.3;
    // return recipe id's
    // the suggestRecipes controller is currently  has a TODO ticket that's
    // meant to return the recipes instead of the hashes
    const suggestions = suggestRecipes(object.ingredients, recipeNumber, recipes);
    res.status(200).json({ recipes: suggestions });
});

module.exports = router;
