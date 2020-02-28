const INGREDIENT_URL: string | undefined = process.env.INGREDIENT_URL || '';

const addUserIngredient = async (username: string): Promise<any> => {
    return fetch(INGREDIENT_URL + username, { method: 'POST' })
        .then((res: any) => {
            return res;
        })
        .catch((error: any) => {
            return error;
        });
};

const deleteUserIngredient = async (username: string): Promise<any> => {
    return fetch(INGREDIENT_URL + username, { method: 'DELETE' })
        .then((res: any) => {
            return res;
        })
        .catch((error: any) => {
            return error;
        });
};

const getUserIngredients = async (username: string): Promise<any> => {
    return fetch(INGREDIENT_URL + '/user/' + username, { method: 'GET' })
        .then((res: any) => {
            return res;
        })
        .catch((error: any) => {
            return error;
        });
};

export { addUserIngredient, deleteUserIngredient, getUserIngredients };
