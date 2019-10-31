"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var express_1 = require("express");
var recipeRouter = express_1.Router();
recipeRouter.get('/', function (req, res) {
    res.send('Hello from Recipe');
});
module.exports = recipeRouter;
