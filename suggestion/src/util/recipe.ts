import axios, { AxiosResponse } from 'axios';
import { hashIngredientList } from './hashIngredientList';

const RECIPE_URL = 'http://localhost:8080';

const getRecipes = async (): Promise<Set<object>> => {
    const params = { count: 0, index: 0 };
    return axios
        .get(`${RECIPE_URL}/recipe`, { params })
        .then((response: AxiosResponse) => {
            const data: object[] = response.status === 200 ? response.data.recipes : [];
            return new Set(data);
        })
        .catch((error: Error) => {
            console.log(error);
            return new Set();
        });
};

const hashRecipes = (recipes: Set<object>, ingredients: any[]): string[] => {
    const ingredientIds: number[] = ingredients.map(({ id }) => id);
    const recipeHashes: string[] = Array.from(recipes).map((recipe: any): string => {
        const recipeIngredientIds = recipe.ingredients.map(({ id }: { id: any }) => id);
        return hashIngredientList(recipeIngredientIds, ingredientIds);
    });
    return recipeHashes;
};

export { getRecipes, hashRecipes };
