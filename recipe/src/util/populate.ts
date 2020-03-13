import { recipeScraperUtil } from './recipeScraper';

const recipeIDs = ['51011', '15431', '172704', '83853', '169084'];
const baseUrl = 'https://www.allrecipes.com/recipe/';

recipeScraperUtil(baseUrl, recipeIDs);
