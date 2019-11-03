"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const recipes_1 = require("../models/recipes");
const userRecipes_1 = require("../models/userRecipes");
exports.initializeRecipeRoutes = (app) => {
    const recipeRouter = express_1.Router();
    app.use('/recipe', recipeRouter);
    /* create a recipe */
    recipeRouter.post('/', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
        const recipe = new recipes_1.RecipesModel(req.body);
        try {
            yield recipe.save().then((item) => res.send(item));
        }
        catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not create the recipe');
        }
    }));
    /* get all the recipes of the user with user_id */
    recipeRouter.get('/user/:user_id', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            const user = yield userRecipes_1.UserRecipesModel.findById(req.params.user_id);
            if (!user) {
                throw new Error(`No user exists with id ${req.params.user_id}`);
            }
            if (!user.recipe_ids || user.recipe_ids.length === 0) {
                res.json('No recipes associated with this user');
            }
            else {
                recipes_1.RecipesModel.find({
                    _id: { $in: user.recipe_ids },
                }, (err, docs) => {
                    res.json(docs);
                });
            }
        }
        catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not fetch the recipes for the user');
        }
    }));
    /* create a user */
    recipeRouter.post('/user', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
        const user = new userRecipes_1.UserRecipesModel(req.body);
        try {
            yield user.save().then((usr) => res.send(usr));
        }
        catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not create the user');
        }
    }));
    /* remove a user */
    recipeRouter.delete('/user/:user_id', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
        try {
            yield userRecipes_1.UserRecipesModel.findByIdAndDelete(req.params.user_id).then((usr) => res.send(`${usr} \n \n Removed from DB`));
        }
        catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not delete the user');
        }
    }));
};
