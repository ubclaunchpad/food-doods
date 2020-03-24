import * as fs from 'fs';
import e, { Application, Router } from 'express';
import { IRecipe, RecipeModel } from '../models/recipes';
import { UserRecipesModel } from '../models/userRecipes';
const recipeScraper = require('recipe-scraper');
const axios = require('axios').default;

const idMap = JSON.parse(fs.readFileSync(`${__dirname}/../../../ingredient/mocks/id_map.json`).toString());

export const initializeRecipeRoutes = (app: Application) => {
    const recipeRouter = Router();
    app.use('/recipe', recipeRouter);

    /* create a recipe */
    recipeRouter.post('/', async (req, res) => {
        const recipe = new RecipeModel(req.body);
        try {
            await recipe.save().then((item: any) => res.send(item));
        } catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not create the recipe');
        }
    });

    /* get all the recipes of the user with user_id */
    recipeRouter.get('/user/:user_id', async (req, res) => {
        try {
            const user = await UserRecipesModel.findById(req.params.user_id);
            if (!user) {
                return res.status(400).send(`No user exists with id ${req.params.user_id}`);
            }
            if (!user.recipe_ids || user.recipe_ids.length === 0) {
                res.json('No recipes associated with this user');
            } else {
                RecipeModel.find(
                    {
                        _id: { $in: user.recipe_ids },
                    },
                    (err, docs) => {
                        res.json(docs);
                    }
                );
            }
        } catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not fetch the recipes for the user');
        }
    });

    /* create a user */
    recipeRouter.post('/user', async (req, res) => {
        const user = new UserRecipesModel(req.body);
        try {
            await user.save().then((usr) => res.send(usr));
        } catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not create the user');
        }
    });

    /* remove a user */
    recipeRouter.delete('/user/:user_id', async (req, res) => {
        try {
            await UserRecipesModel.findByIdAndDelete(req.params.user_id).then((usr) =>
                res.send(`${usr} \n \n Removed from DB`)
            );
        } catch (e) {
            console.error(e);
            res.status(500);
            res.json('Could not delete the user');
        }
    });

    /* gets a recipe associated to an id*/
    recipeRouter.get('/recipe/:recipe_id', async (req, res) => {
        try {
            const recipe = await RecipeModel.findById(req.params.recipe_id);
            if (recipe === null) {
                res.status(404).send(`No such recipe found with query ${req.query}`);
            } else {
                res.status(200);
                res.json(recipe);
            }
        } catch (e) {
            res.status(500).send(`Could not get the recipe with id ${req.params.id} for ${e.message}`);
        }
    });

    /* gets 'count' number of recipes starting at position 'index'*/
    recipeRouter.get('/recipe', async (req, res) => {
        try {
            let { count, index } = req.query;
            count = parseInt(count, 10);
            index = parseInt(index, 10) - 1;
            const recipes = await RecipeModel.find()
                .skip(index)
                .limit(count);
            if (recipes === null || recipes.length === 0) {
                res.status(404).send(`No such recipes found with query ${req.query}`);
            } else {
                res.status(200);
                res.json(recipes);
            }
        } catch (e) {
            res.status(500).send(`Could not get the recipes with query ${req.query} for ${e.message}`);
        }
    });

    recipeRouter.post('/recipe-scraper', async (req, res) => {
        if (!req.body.recipeUrl) {
            return res.status(400).send('Please pass recipeUrl in the body');
        }
        recipeScraper(req.body.recipeUrl)
            .then(async (recipe: any) => {
                const ingredients = recipe.ingredients;
                let resAxios = await axios.post('http://localhost:9000/parse/', { ingredients });

                recipe.ingredients = resAxios.data.ingredients;
                const postRecipe = new RecipeModel(recipe);
                try {
                    const r = await postRecipe.save();
                    return res.send(r);
                } catch (e) {
                    return res.status(500).send(e.message);
                }
            })
            .catch((error: any) => res.status(500).send(error.message));
    });
};
