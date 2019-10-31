import * as mongoose from 'mongoose';

export interface IRecipes extends mongoose.Document {
    user_id: string;
    recipe_ids: array;
}

export const Recipes = new mongoose.Schema({
    name: {
        type: String,
    },
    description: {
        type: Array,
    },
    instructions: {
        type: Array,
    },
    ingredients: {
        type: Array,
    },
});

export const RecipesModel = mongoose.model<IRecipes>('Recipes', Recipes);
