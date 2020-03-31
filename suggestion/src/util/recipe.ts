import axios, { AxiosResponse } from 'axios';

const RECIPE_URL = 'http://localhost:8080';

const getRecipes = async (): Promise<Set<object>> => {
    const params = { count: 0, index: 0 };
    return axios
        .get(`${RECIPE_URL}/recipe`, { params })
        .then((response: AxiosResponse) => {
            const data: object[] = response.status === 200 ? response.data.recipes : [];
            return new Set(data);
        })
        .catch(() => new Set());
};

const hashRecipes = (recipes: Set<object>, ingredients: any[]): string[] => {
    const ingredientIds: number[] = ingredients.map(({ id }: { id: number }) => id);
    const max: number = Math.max(...ingredientIds);
    const recipeHashes = Array(recipes).map((recipe: any): string => {
        const hashArray = Array(max + 1).fill(0);

        const recipeIngredients = recipe.ingredients;
        for (const ingredient of recipeIngredients) {
            hashArray[hashArray.length - ingredient.id - 1] = 1;
        }

        return hashArray.toString();
    });
    return recipeHashes;
};

export { getRecipes, hashRecipes };
