import { Router } from 'express';
import * as controllers from './ingredient.controller';

const router = Router();

router.post('/:userId', controllers.addIngredient);

export { router };
