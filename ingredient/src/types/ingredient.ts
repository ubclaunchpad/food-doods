export type UnitCategory = 1 | 2 | 3;

export interface IIngredient {
    id: number;
    name: string;
    unitCategory: UnitCategory;
}

export interface IRecipeIngredient extends IIngredient {
    quantity: number;
}
