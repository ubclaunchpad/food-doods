"use strict";
exports.__esModule = true;
var express = require("express");
var gateway = express();
var PORT = 6000;
gateway.use(express.json());
gateway.get('/', function (req, res) {
    res.status(200).send('Suggestion service endpoint');
});
gateway.get('/withIngredients', function (req, res) {
    res.status(200).send('Test API endpoint');
});
gateway.post('/', function (req, res) {
    res.status(200).send('Received HTPP POST at URL: ' + req.url);
});
gateway.post('/withIngredients', function (req, res) {
    // const httpBody = JSON.parse(req.body);
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
gateway.put('/', function (req, res) {
    res.status(200).send('Received HTTP PUT at URL: ' + req.url);
});
gateway["delete"]('/', function (req, res) {
    res.status(200).send('Received HTTP DELETE at URL: ' + req.url);
});
gateway.listen(PORT, function () {
    console.log("[Suggestion] running on port " + PORT);
});
