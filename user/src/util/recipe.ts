import axios from 'axios';

const RECIPE_PORT: string = process.env.RECIPE_PORT || '8080';
const RECIPE_URL: string = `http://localhost:${RECIPE_PORT}`;

const addUserRecipe = async (userId: string): Promise<any> => {
    return axios
        .post(`${RECIPE_URL}/user`, { userId, recipes: [] })
        .then((res: any) => res)
        .catch((error: Error) => error);
};

const deleteUserRecipe = async (userId: string): Promise<any> => {
    return axios
        .delete(`${RECIPE_URL}/user/${userId}`)
        .then((res: any) => res)
        .catch((error: Error) => error);
};

export { addUserRecipe, deleteUserRecipe };
