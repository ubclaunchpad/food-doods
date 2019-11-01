import { Router } from 'express';
import * as controllers from './user.controller';

const router = Router();

router.post('/', controllers.addUser);
router.delete('/', controllers.deleteUser);

export { router };
