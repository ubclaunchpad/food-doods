import { Router } from 'express';
import * as controllers from './user.controller';

const userRouter = Router();

userRouter.post('/:userId', controllers.addUser);
userRouter.delete('/:userId', controllers.deleteUser);

export { userRouter };
