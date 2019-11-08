import { Router } from 'express';
import * as controllers from './ingredient.controller';

const ingredientRouter = Router();

ingredientRouter
    .route('/:userId')
    .post(controllers.addIngredient)
    .put(controllers.updateIngredient)
    .delete(controllers.deleteIngredient);

export { ingredientRouter };
