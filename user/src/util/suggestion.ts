const INGREDIENT_URL: string | undefined = process.env.INGREDIENT_URL || '';
const SUGGESTION_URL: string | undefined = process.env.SUGGESTION_URL || '';

const getUserSuggestion = async (username: string): Promise<any> => {
    fetch(`${INGREDIENT_URL}user/` + username, { method: 'GET' })
        .then((res: any) => {
            // assuming that each ingredient is in the format: { id: string, quantity: number, unit: string }
            const ingredientIds = res.map(({ id }: { id: string }) => id);
            return fetch(SUGGESTION_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ queryIngredients: ingredientIds }),
            });
        })
        .then((res: any) => {
            // should be the list of top recipes recommended to the user
            return res;
        })
        .catch((error: any) => {
            return error;
        });
};

export { getUserSuggestion };
