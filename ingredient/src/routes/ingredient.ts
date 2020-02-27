import { Router } from 'express';
import * as controllers from '../controllers/ingredient';

/*
 * Responsible for managing general ingredient data within the application
 */
const ingredientRouter = Router();

/*
 * POST /ingredient/:userId
 *
 * adds an ingredient and quantity to a user inventory
 *
 * TODO: migrate to user route
 */
ingredientRouter.post('/:userId', controllers.addIngredient);

/*
 * PUT /ingredient/:userId
 *
 * updates an ingredient quantity within a user inventory
 *
 * TODO: mirate to user route
 */
ingredientRouter.put('/:userId', controllers.updateIngredient);

/*
 * DELETE /ingredient/:userId
 *
 * deletes an ingredient (regardless of quantity) from a user inventory
 *
 * TODO: migrate to user route
 */
ingredientRouter.delete('/:userId', controllers.deleteIngredient);

/*
 * GET /ingredient/search
 *
 * Performs an Edamam API ingredient search
 */
ingredientRouter.route('/search').get(controllers.searchIngredient);

export { ingredientRouter };
