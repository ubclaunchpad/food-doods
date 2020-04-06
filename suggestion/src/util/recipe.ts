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

const hashRecipes = (recipes: Set<object>, allIngredientIds: number[]): object => {
    const recipeHashes: object = Array.from(recipes).map((recipe: any): object => {
        const recipeIngredientIds: number[] = recipe.ingredients.map(({ id }) => id);
        return {
            id: recipe._id,
            ingredients: hashIngredientList(recipeIngredientIds, allIngredientIds),
        };
    });

    return recipeHashes;
};

export { getRecipes, hashRecipes };
