import axios from 'axios';

const INGREDIENT_PORT: string = process.env.INGREDIENT_PORT || '9000';
const INGREDIENT_URL: string = `http://localhost:${INGREDIENT_PORT}`;

const addUserIngredient = async (userId: string): Promise<any> => {
    return axios
        .post(`${INGREDIENT_URL}/user`, { externalId: userId })
        .then((res: any) => res)
        .catch((error: Error) => error);
};

const deleteUserIngredient = async (userId: string): Promise<any> => {
    return axios
        .delete(`${INGREDIENT_URL}/${userId}`)
        .then((res: any) => res)
        .catch((error: Error) => error);
};

export { addUserIngredient, deleteUserIngredient };
