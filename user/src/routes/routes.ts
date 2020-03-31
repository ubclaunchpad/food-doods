import { Application, Router } from 'express';
import { postUserLogin } from '../controllers/login';
import { postUserSuggestion } from '../controllers/suggestion';
import * as userController from '../controllers/user';

export const initializeUserRoutes = (app: Application) => {
    const userRouter = Router();
    app.use('/user', userRouter);

    userRouter.get('/:username', userController.getUser);
    userRouter.post('/', userController.postUser);
    userRouter.delete('/:username', userController.deleteUser);
    userRouter.patch('/', async (req, res) => {
        res.status(200).send('Working user patch route');
    });

    userRouter.post('/login', postUserLogin);

    userRouter.post('/suggestion', postUserSuggestion);
};
