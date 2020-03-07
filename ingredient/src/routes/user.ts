import { Router } from 'express';
import * as controller from '../controllers/user';
import { userListRouter } from './user-list';

/*
 * Responsible for handling users within the application
 *
 * TODO:
 * 1. generate and validate a token to confirm that this field is only
 * being accessed by services within the back-end
 */
const userRouter = Router();

userRouter.use('/ingredient', userListRouter);

/*
 * POST /user/
 *
 * generates a new user within the service database
 */
userRouter.post('/', controller.addUser);

/*
 * DELETE /user/:id
 *
 * delete a user and their ingredient inventory from the service database
 */
userRouter.delete('/:id', controller.deleteUser);

export { userRouter };
