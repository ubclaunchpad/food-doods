import { Router } from 'express';
import * as controllers from './ingredient.controller';

const ingredientRouter = Router();

ingredientRouter.post('/:userId', controllers.addIngredient);

export { ingredientRouter };
