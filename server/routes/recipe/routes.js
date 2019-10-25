const express = require('express');
const recipeRouter = express.Router();

recipeRouter.get('/', (req, res) => {
    res.send('Hello from Recipe');
});

module.exports = recipeRouter;