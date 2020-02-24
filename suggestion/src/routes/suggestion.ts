import * as express from 'express';
import { suggestRecipeController } from '../controller/suggestRecipe';

const router = express.Router();

// POST /suggestion?ingredients=xyz
router.post('/', suggestRecipeController);

module.exports = router;
