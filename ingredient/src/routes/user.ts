import { Router } from 'express';
import * as controllers from '../controllers/user';

/*
 * Responsible for handling user-owned ingredient lists within the application
 *
 * TODO:
 * 1. generate and validate a token to confirm that this field is only
 * being accessed by services within the back-end
 *
 * 2. migrate user-based ingredient adding/updating/deleting to use these endpoints
 */

const userRouter = Router();

/*
 * POST /user/:id
 *
 * generates a new user within the service database
 */
userRouter.post('/:userId', controllers.addUser);

/*
 * DELETE /user/:id
 *
 * delete a user and their ingredient inventory from the service database
 */
userRouter.delete('/:userId', controllers.deleteUser);

export { userRouter };
