import { Router } from 'express';
import * as controller from '../controllers/user-list';

/*
 * Responsible for handling user-owned ingredient lists within the application
 *
 * TODO:
 * 1. generate and validate a token to confirm that this field is only
 * being accessed by services within the back-end
 */
const userListRouter = Router();

/*
 * GET /user/ingredient/:id
 *
 * retrieves the list of ingredients owned by a user
 */
userListRouter.get('/:id', controller.getIngredients);

/*
 * POST /user/ingredient/:id
 *
 * add an ingredient to a user's list
 */
userListRouter.post('/', controller.addIngredient);

/*
 * PATCH /user/ingredient/:id
 *
 * update the quantity of an ingredient in a user's list
 */
userListRouter.patch('/:id', controller.updateIngredient);

/*
 * DELETE /user/ingredient/:id
 *
 * delete an ingredient from a user's list
 */
userListRouter.delete('/:id', controller.deleteIngredient);

export { userListRouter };
