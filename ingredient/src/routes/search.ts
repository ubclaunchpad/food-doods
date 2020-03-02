import { Router } from 'express';
import * as controller from '../controllers/search';

/*
 * Responsible for searching through the ingredient DB
 *
 * TODO:
 * 1. (stretch) refactor this with ElasticSearch functionality
 */
const searchRouter = Router();

/*
 * GET /search?query=...
 *
 * retrieves a list of ingredients that contain the query string in the name
 */
searchRouter.get('/', controller.searchIngredient);

export { searchRouter };
