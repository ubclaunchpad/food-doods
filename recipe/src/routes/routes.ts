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

    /* get all recipes - limit and skip can be sent through params */
    recipeRouter.get('/', async (req, res) => {
        try {
            const recipes = RecipesModel.find()
                .skip(Number(req.params.skip))
                .limit(Number(req.params.limit));
            if (recipes === null) {
                throw new Error('No recipes found');
            }
            await res.json(recipes);
        } catch (e) {
            console.error(e);
            res.status(500).send(e);
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
};
