"use strict";
exports.__esModule = true;
var suggestRecipe_1 = require("./controller/suggestRecipe");
var express = require("express");
var suggestionService = express();
var PORT = 6000;
suggestionService.use(express.json());
suggestionService.get('/', function (req, res) {
    res.status(200).send('Suggestion service endpoint');
});
suggestionService.get('/withIngredients', function (req, res) {
    // res.status(200).send('Test API endpoint');
    var httpBody = req.body;
    var numIngredients = httpBody.queryIngredients.length;
    var testThreshold = 5;
    console.log('Using test threshold: ' + testThreshold);
    var IDs = [];
    for (var i = 0; i < numIngredients; i++) {
        IDs.push(httpBody.queryIngredients[i].databaseID);
    }
    // const recipeHashes = 
    suggestRecipe_1.suggestRecipes(IDs, testThreshold);
    console.log('returned from suggestRecipes');
    res.status(200).send('Result: ');
});
suggestionService.post('/', function (req, res) {
    res.status(200).send('Received HTPP POST at URL: ' + req.url);
});
suggestionService.post('/withIngredients', function (req, res) {
    var httpBody = req.body;
    var numIngredients = httpBody.queryIngredients.length;
    console.log('DEBUG: numIngredients = ' + numIngredients);
    var responseText = 'Got ingredients: ';
    for (var i = 0; i < numIngredients; i++) {
        responseText = responseText.concat(httpBody.queryIngredients[i].commonName);
        if (i < numIngredients - 1) {
            responseText = responseText.concat(', ');
        }
    }
    res.status(200).send(responseText);
});
suggestionService.put('/', function (req, res) {
    res.status(200).send('Received HTTP PUT at URL: ' + req.url);
});
suggestionService["delete"]('/', function (req, res) {
    res.status(200).send('Received HTTP DELETE at URL: ' + req.url);
});
suggestionService.listen(PORT, function () {
    console.log("[Suggestion] running on port " + PORT);
});
/*
============ Sample POST request =============

curl --header "Content-Type: application/json" \
  --request GET \
  --data '{
    "userID": "123456789",
    "queryIngredients": [
        {
            "commonName": "broccoli",
            "databaseID": 1
        },
        {
            "commonName": "beef",
            "databaseID": 5
        },
        {
            "commonName": "garlic",
            "databaseID": 13
        },
        {
            "commonName": "brown rice",
            "databaseID": 7
        }
    ]
}' \http://localhost:6000/withIngredients
  
*/
