import { IIngredient } from '../types';
import { db } from './connection';

export const insertIntoIngredient = (ingredient: IIngredient) => {
    const { name, category } = ingredient;
    return db.one('insert into ingredient (name, category) values ($1, $2) returning ingredient_id', [name, category]);
};
