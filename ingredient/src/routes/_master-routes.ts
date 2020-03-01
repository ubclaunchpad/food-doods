import { Router } from 'express';
import { ingredientRouter } from './ingredient';
import { userRouter } from './user';

const masterRouter = Router();

masterRouter.use('/ingredient', ingredientRouter);
masterRouter.use('/user', userRouter);
masterRouter.get('/', (req, res) => {
    res.send('Ingredient Service');
});

export { masterRouter };
