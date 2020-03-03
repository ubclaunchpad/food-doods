import { Application, Router } from 'express';

export const initializeUserRoutes = (app: Application) => {
    const userRouter = Router();
    app.use('/user', userRouter);

    /* gets a user */
    userRouter.get('/', async (req, res) => {
        res.status(200).send("Working user get route")
    });

    /* posts a user */
    userRouter.post('/', async (req, res) => {
        res.status(200).send("Working user post route")
    });

    /* deletes a user */
    userRouter.delete('/', async (req, res) => {
        res.status(200).send("Working user delete route")
    });

    /* patches a user */
    userRouter.patch('/', async (req, res) => {
        res.status(200).send("Working user patch route")
    });
};
