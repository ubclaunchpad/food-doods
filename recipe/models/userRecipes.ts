import * as mongoose from 'mongoose';

export interface IUserRecipes extends mongoose.Document {
    user_id: string;
    recipe_ids: array;
}

export const UserRecipes = new mongoose.Schema({
    user_id: {
        type: String,
        required: true,
    },
    recipe_ids: {
        type: Array,
    },
});

export const UserRecipesModel = mongoose.model<IUserRecipes>('UserRecipes', UserRecipes);
