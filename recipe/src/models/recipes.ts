import * as mongoose from 'mongoose';

export interface IRecipe extends mongoose.Document {
    name: string;
    ingredients: string[];
    instructions: string[];
    time: string;
    servings: string;
}

export interface IIngredient extends mongoose.Document {
    id: number;
    name: string;
    unit_category: number;
}

const time = new mongoose.Schema({
    prep: { type: String },
    cook: { type: String },
    active: { type: String },
    inactive: { type: String },
    ready: { type: String },
    total: { type: String },
});

export const Ingredient = new mongoose.Schema(
    {
        id: {
            type: Number,
            required: true,
        },
        name: {
            type: String,
            required: true,
        },
        unit_category: {
            type: Number,
        },
    },
    { _id: false }
);

export const Recipe = new mongoose.Schema({
    name: {
        type: String,
    },
    ingredients: {
        type: [Ingredient],
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

export const RecipeModel = mongoose.model<IRecipe>('Recipe', Recipe);
