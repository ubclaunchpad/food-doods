import * as mongoose from 'mongoose';

export interface IUserRecipes extends mongoose.Document {
    user_name: string;
    recipe_ids: string[];
}

export const UserRecipes = new mongoose.Schema({
    user_name: {
        type: String,
        required: true,
    },
    recipe_ids: {
        type: Array,
        default: [],
    },
});

export const UserRecipesModel = mongoose.model<IUserRecipes>('UserRecipes', UserRecipes);
