import { Application, Router } from 'express';
import { RecipesModel } from '../models/recipes';
import { UserRecipesModel } from '../models/userRecipes';

export const initializeRecipeRoutes = (app: Application) => {
    const recipeRouter = Router();
    app.use('/recipe', recipeRouter);

    /* create a recipe */
    recipeRouter.post('/', async (req, res) => {
        const recipe = new RecipesModel(req.body);
        try {
            await recipe.save().then((item) => res.send(item));
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
                throw new Error(`No user exists with id ${req.params.user_id}`);
            }
            if (!user.recipe_ids || user.recipe_ids.length === 0) {
                res.json('No recipes associated with this user');
            } else {
                RecipesModel.find(
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
            const recipe = await RecipesModel.findById(req.params.recipe_id);
            if (recipe === null) {
                res.status(404).send(`No such recipes found with query ${req.query}`);
            }
            else {
                res.status(200);
                await res.json(recipe);
            }
        } catch (e) {
            res.status(500).send(`Could not get the recipe with id ${req.params.id} for ${e.message}`);
        }
    });

    /* gets 'count' number of recipes starting at position 'index'*/
    recipeRouter.get('/recipe', async (req, res) => {
        try {
            let { count, index } = req.query;
            count = parseInt(count)
            index = parseInt(index) - 1
            const recipes = await RecipesModel.find().skip(index).limit(count);
            if (recipes === null || recipes.length === 0) {
                res.status(404).send(`No such recipes found with query ${req.query}`);
            }
            else {
                res.status(200);
                await res.json(recipes);
            }
        } catch (e) {
            res.status(500).send(`Could not get the recipes with query ${req.query} for ${e.message}`);
        }
    });
};
