import { Router } from 'express';
import * as controller from '../controllers/ingredient';

/*
 * Responsible for managing general ingredient data within the application
 */
const ingredientRouter = Router();

ingredientRouter.get('/', controller.getIngredients);

ingredientRouter.get('/:id', controller.getIngredients);

ingredientRouter.post('/', controller.postIngredient);

ingredientRouter.patch('/:id', controller.patchIngredient);

ingredientRouter.delete('/:id', controller.deleteIngredient);

export { ingredientRouter };
