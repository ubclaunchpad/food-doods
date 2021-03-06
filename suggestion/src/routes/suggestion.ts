import axios from 'axios';
import { Request, Response, Router } from 'express';
import { suggestRecipes } from '../controller/suggestRecipe';
import { getRecipes, hashRecipes } from '../util/recipe';

const router = Router();

// POST /suggestion?ingredients=xyz
router.post('/', async (req: Request, res: Response) => {
    try {
        const httpBody = req.body;
        const numIngredients = httpBody.queryIngredients.length;

        const testThreshold = 0.5;

        const IDs = [];

        for (let i = 0; i < numIngredients; i++) {
            IDs.push(httpBody.queryIngredients[i].databaseID);
        }

        const {
            data: { ingredients: allIngredients },
        } = await axios.get(`http://localhost:${process.env.INGREDIENT_PORT}/ingredient`);

        const recipeHashes = suggestRecipes(IDs, allIngredients, testThreshold);
        return res.status(200).json({ hashes: recipeHashes });
    } catch (error) {
        return res.status(500).json({ error });
    }
});

// POST /suggestion/:userId
router.post('/:userId', async (req: Request, res: Response) => {
    try {
        const allIngredientsResponse = axios.get(`http://localhost:${process.env.INGREDIENT_PORT}/ingredient`);
        const userIngredientsResponse = axios.get(
            `http://localhost:${process.env.INGREDIENT_PORT}/user/ingredient/${req.params.userId}`
        );
        const [
            {
                data: { ingredients: allIngredients },
            },
            {
                data: { ingredients: userIngredients },
            },
        ] = await Promise.all([allIngredientsResponse, userIngredientsResponse]);

        const allIngredientIds: number[] = allIngredients.map(({ id }) => id);
        const ingredientIds: number[] = userIngredients.map(({ id }) => id);

        const setOfRecipes: Set<object> = await getRecipes();
        const suggestions = suggestRecipes(ingredientIds, allIngredientIds, 0.1, setOfRecipes);

        return res.status(200).json({ recipes: suggestions });
    } catch (error) {
        return res.status(500).json({ error });
    }
});

export { router };
