import * as mongoose from 'mongoose';

export interface IRecipes extends mongoose.Document {
    name: string;
    ingredients: string[];
    instructions: string[];
    time: string;
    servings: string;
}

const time = new mongoose.Schema({
    prep: { type: String },
    cook: { type: String },
    active: { type: String },
    inactive: { type: String },
    ready: { type: String },
    total: { type: String },
});

export const Recipes = new mongoose.Schema({
    name: {
        type: String,
    },
    ingredients: {
        type: Array,
    },
    instructions: {
        type: Array,
    },
    time: {
        type: time,
    },
    servings: {
        type: String,
    },
});

export const RecipesModel = mongoose.model<IRecipes>('Recipes', Recipes);
