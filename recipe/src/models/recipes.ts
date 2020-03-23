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

const time = new mongoose.Schema(
    {
        prep: { type: String },
        cook: { type: String },
        active: { type: String },
        inactive: { type: String },
        ready: { type: String },
        total: { type: String },
    },
    { _id: false }
);

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
        quantity: {
            type: Number,
        },
        unit: {
            type: String,
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

Recipe.statics.bulkInsert = function(models: string | any[], fn: (arg0: string | null) => any) {
    if (!models || !models.length) return fn(null);

    var bulk = this.collection.initializeOrderedBulkOp();
    if (!bulk) return fn('bulkInsertModels: MongoDb connection is not yet established');

    var model;
    for (var i = 0; i < models.length; i++) {
        model = models[i];
        bulk.insert(model.toJSON());
    }

    bulk.execute(fn);
};

export const RecipeModel = mongoose.model<IRecipe>('Recipe', Recipe);
