import { Application, Router, Request, Response } from 'express';
import { Document } from 'mongoose';
import { IRecipes, RecipesModel } from '../models/recipes';
import { UserRecipesModel } from '../models/userRecipes';
const recipeScraper = require('recipe-scraper');

export const initializeRecipeRoutes = (app: Application) => {
    const recipeRouter = Router();
    app.use('/recipe', recipeRouter);

    /* create a recipe */
    recipeRouter.post('/', async (req: Request, res: Response) => {
        const recipe = new RecipesModel(req.body);
        try {
            await recipe.save().then((recipe: Document) => res.status(201).json({ recipe }));
        } catch (e) {
            console.error(e);
            res.status(500).json('Could not create the recipe');
        }
    });

    /* get all the recipes of the user with user_id */
    recipeRouter.get('/user/:user_id', async (req: Request, res: Response) => {
        try {
            const user = await UserRecipesModel.findById(req.params.user_id);
            if (!user) {
                return res.status(400).send(`No user exists with id ${req.params.user_id}`);
            }
            if (!user.recipe_ids || user.recipe_ids.length === 0) {
                res.status(200).send('No recipes associated with this user');
            } else {
                RecipesModel.find(
                    {
                        _id: { $in: user.recipe_ids },
                    },
                    (err: Error, recipes: Document) => {
                        if (err) {
                            throw err;
                        }
                        res.status(200).json({ recipes });
                    }
                );
            }
        } catch (e) {
            console.error(e);
            res.status(500).send('Could not fetch the recipes for the user');
        }
    });

    /* updates saved list of recipes for user with user_id */
    recipeRouter.patch('/user/:user_id', async (req: Request, res: Response) => {
        try {
            await UserRecipesModel.updateOne({ user_name: req.params.user_id }, { recipe_ids: req.body.recipes });
            return res.status(204).send();
        } catch (e) {
            console.error(e);
            res.status(500).send('Could not fetch the recipes for the user');
        }
    });

    /* create a user */
    recipeRouter.post('/user', async (req: Request, res: Response) => {
        const user = new UserRecipesModel(req.body);
        try {
            await user.save().then((user: Document) => res.status(204).send(user.toObject()));
        } catch (e) {
            console.error(e);
            res.status(500).send('Could not create the user');
        }
    });

    /* remove a user */
    recipeRouter.delete('/user/:user_id', async (req: Request, res: Response) => {
        try {
            await UserRecipesModel.findByIdAndDelete(req.params.user_id).then((user: Document | null) => {
                if (!user) {
                    throw new Error(`No user exists with id ${req.params.user_id}`);
                }
                const username: string = user.get('username');
                res.status(200).send(`${username} \n \n Removed from DB`);
            });
        } catch (e) {
            console.error(e);
            res.status(500).send('Could not delete the user');
        }
    });

    /* gets a recipe associated to an id*/
    recipeRouter.get('/recipe/:recipe_id', async (req: Request, res: Response) => {
        try {
            const recipe = await RecipesModel.findById(req.params.recipe_id);
            if (recipe === null) {
                res.status(404).send(`No such recipe found with query ${req.query}`);
            } else {
                res.status(200).json({ recipe });
            }
        } catch (e) {
            res.status(500).send(`Could not get the recipe with id ${req.params.id} for ${e.message}`);
        }
    });

    /* gets 'count' number of recipes starting at position 'index'*/
    recipeRouter.get('/recipe', async (req: Request, res: Response) => {
        try {
            let { count, index } = req.query;
            count = parseInt(count, 10);
            index = parseInt(index, 10) - 1;
            const recipes = await RecipesModel.find()
                .skip(index)
                .limit(count);
            recipes.forEach((recipe: Document) => recipe.toObject());
            if (recipes === null || recipes.length === 0) {
                res.status(404).send(`No such recipes found with query ${req.query}`);
            } else {
                res.status(200).json({ recipes });
            }
        } catch (e) {
            res.status(500).send(`Could not get the recipes with query ${req.query} for ${e.message}`);
        }
    });

    recipeRouter.post('/recipe-scraper', async (req: Request, res: Response) => {
        if (!req.body.recipeUrl) {
            return res.status(400).send('Please pass recipeUrl in the body');
        }
        recipeScraper(req.body.recipeUrl)
            .then(async (recipe: IRecipes) => {
                const postRecipe = new RecipesModel(recipe);
                return postRecipe
                    .save()
                    .then((recipes: Document) => res.status(201).json({ recipes }))
                    .catch(() => res.status(500).send('Could not save to DB'));
            })
            .catch(() => {
                return res.status(404).send('No recipe found on the page');
            });
    });
};
