import { Application, Router } from 'express';
import { postUserLogin } from '../controllers/login';
import { getUser, postUser } from '../controllers/user'

export const initializeUserRoutes = (app: Application) => {
    const userRouter = Router();
    app.use('/user', userRouter);

    /* gets a user */
    userRouter.get('/', async (req, res) => {
        res.status(200).send('Working user get route');
    });

    /* posts a user */
    userRouter.post('/', async (req, res) => {
        try {
            postUser(req, res)
        } catch (e) {
            res.status(400).send(e.message);
        }
    });

    /* deletes a user */
    userRouter.delete('/', async (req, res) => {
        res.status(200).send('Working user delete route');
    });

    /* patches a user */
    userRouter.patch('/', async (req, res) => {
        res.status(200).send('Working user patch route');
    });

    userRouter.post('/login', postUserLogin);
};
