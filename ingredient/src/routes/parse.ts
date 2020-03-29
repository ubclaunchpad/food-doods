import { Router } from 'express';
import * as controllers from '../controllers/parse';

const parseRouter = Router();

parseRouter.post('/', controllers.parse);

export { parseRouter };
