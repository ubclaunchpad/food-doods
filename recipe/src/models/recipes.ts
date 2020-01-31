import * as mongoose from 'mongoose';

export interface IRecipes extends mongoose.Document {
    recipe_name: string;
    description: string;
    instructions: string[];
    ingredients: string[];
}

export const Recipes = new mongoose.Schema({
    recipe_name: {
        type: String,
    },
    description: {
        type: String,
    },
    instructions: {
        type: Array,
    },
    ingredients: {
        type: Array,
    },
    hash: {
        type: String,
    },
});

export const RecipesModel = mongoose.model<IRecipes>('Recipes', Recipes);
