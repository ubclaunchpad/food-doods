import * as express from 'express';

const router = express.Router();

// GET /suggestion?ingredients=xyz
router.get('/', (req, res) => {
    // res.status(200).send('Test API endpoint');

    const httpBody = req.body;
    const numIngredients = httpBody.queryIngredients.length;

    const testThreshold = 5;
    console.log('Using test threshold: ' + testThreshold);

    const IDs = [];

    for (let i = 0; i < numIngredients; i++) {
        IDs.push(httpBody.queryIngredients[i].databaseID);
    }

    const recipeHashes = suggestRecipes(IDs, testThreshold);
    console.log('returned from suggestRecipes');

    res.status(200).send('Result: ' + recipeHashes);
});

module.exports = router;
