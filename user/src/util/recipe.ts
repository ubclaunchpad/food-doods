const RECIPE_URL: string | undefined = process.env.RECIPE_URL || '';

const addUserRecipe = async (username: string): Promise<any> => {
    return fetch(RECIPE_URL + username, { method: 'POST' })
        .then((res: any) => {
            return res;
        })
        .catch((error: any) => {
            return error;
        });
};

const deleteUserRecipe = async (username: string): Promise<any> => {
    return fetch(RECIPE_URL + username, { method: 'DELETE' })
        .then((res: any) => {
            return res;
        })
        .catch((error: any) => {
            return error;
        });
};

export { addUserRecipe, deleteUserRecipe };
