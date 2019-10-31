import { Application, Router } from 'express';
import { Recipes } from '../models/recipes';
import { UserRecipes } from '../models/userRecipes';

export const initializeRecipeRoutes = (app: Application) => {
    const recipeRouter = Router();
    app.use('/recipe', recipeRouter);

    recipeRouter.get('/', async (req, res) => {
        res.send('Hello from Recipe');
    });
};
