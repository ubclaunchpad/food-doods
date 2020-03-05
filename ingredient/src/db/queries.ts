import { IIngredient } from '../types/_master-types';
import { db } from './connection';

export const insertIntoIngredient = (ingredient: IIngredient) => {
    return db.none('insert into ingredient values ($1, $2, $3)', [ingredient.id, ingredient.name, ingredient.category]);
};
