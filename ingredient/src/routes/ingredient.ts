import { Router } from 'express';
import * as controller from '../controllers/ingredient';

/*
 * Responsible for managing general ingredient data within the application
 */
const ingredientRouter = Router();

ingredientRouter.get('/:id', (req, res) => {
    res.send('stub');
});

ingredientRouter.post('/', (req, res) => {
    res.send('stub');
});

ingredientRouter.patch('/:id', (req, res) => {
    res.send('stub');
});

ingredientRouter.delete('/:id', (req, res) => {
    res.send('stub');
});

export { ingredientRouter };
