import { Application, Router } from 'express';
import { postUserLogin } from '../controllers/login';
import { postUserSuggestion } from '../controllers/suggestion';
import * as userController from '../controllers/user';

export const initializeUserRoutes = (app: Application) => {
    const userRouter = Router();
    app.use('/user', userRouter);

    /* gets a user */
    userRouter.get('/:username', userController.getUser);

    /* posts a user */
    userRouter.post('/', userController.postUser);

    /* deletes a user */
    userRouter.delete('/', async (req, res) => {
        res.status(200).send('Working user delete route');
    });

    /* patches a user */
    userRouter.patch('/', async (req, res) => {
        res.status(200).send('Working user patch route');
    });

    /* user login */
    userRouter.post('/login', postUserLogin);

    /* retrieves recipe suggestion for user */
    userRouter.post('/suggestion', postUserSuggestion);
};
