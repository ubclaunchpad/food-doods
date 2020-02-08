import * as express from 'express';
import { suggestRecipes } from '../controller/suggestRecipe';

const router = express.Router();

// POST /suggestion?ingredients=xyz
router.post('/', (req, res) => {
    // res.status(200).send('Test API endpoint');

    const httpBody = req.body;
    const numIngredients = httpBody.queryIngredients.length;

    const testThreshold = 0.5;

    const IDs = [];

    for (let i = 0; i < numIngredients; i++) {
        IDs.push(httpBody.queryIngredients[i].databaseID);
    }

    const recipeHashes = suggestRecipes(IDs, testThreshold);
    res.status(200).send('Result: ' + recipeHashes);
});

module.exports = router;
