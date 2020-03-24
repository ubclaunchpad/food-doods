import { Router } from 'express';
import { ingredientRouter } from './ingredient';
import { parseRouter } from './parse';
import { searchRouter } from './search';
import { userRouter } from './user';

const masterRouter = Router();

masterRouter.use('/ingredient', ingredientRouter);
masterRouter.use('/parse', parseRouter);
masterRouter.use('/search', searchRouter);
masterRouter.use('/user', userRouter);
masterRouter.get('/', (req, res) => {
    res.send('Ingredient Service');
});

export { masterRouter };
