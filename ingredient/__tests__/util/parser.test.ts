import { IRecipeIngredient } from '../../src/types/ingredient';
import { getQuantity, parse } from '../../src/util/parser';

const testIngredients = ['6 eggs', 'hello', '1/4 teaspoon salt', '1 1/4 cups buttermilk', '2 (6 ounce) cans tomatoes'];

describe('Ingredient Parser', () => {
    describe('Parse Quantity', () => {
        const cases: Array<[string, [number, string], string]> = [
            ['6 eggs', [6, 'eggs'], 'Should parse a simple number at start of ingredient'],
            ['hello', [null, 'hello'], "Should return null if ingredient doesn't start with a number"],
            ['1/4 teaspoon salt', [0.25, 'teaspoon salt'], 'Should parse fractions'],
            ['1 1/4 cups buttermilk', [1.25, 'cups buttermilk'], 'Should parse mixed numbers'],
            ['2 (6 ounce) cans tomatoes', [6, 'ounce) cans tomatoes'], 'Should prioritize quantities inside brackets'],
        ];
        cases.forEach(([ingredient, quantity, message]) => {
            it(message, () => {
                expect(getQuantity(ingredient)).toEqual(quantity);
            });
        });
    });

    describe('Parser', () => {
        const cases: Array<[string, IRecipeIngredient, string]> = [];
        testIngredients.forEach((ingredient) => {});
    });
});
