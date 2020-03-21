import { IRecipeIngredient } from '../../src/types/ingredient';
import { getQuantity, parse } from '../../src/util/parser';

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
        const cases: Array<[string, IRecipeIngredient]> = [
            ['6 eggs', { id: 0, quantity: 6, name: 'egg', unitCategory: 3 }],
            ['hello', null],
            ['1/4 teaspoon salt', { id: 0, quantity: 0.25, name: 'salt', unitCategory: 1 }],
            ['1 1/4 cups buttermilk', { id: 0, quantity: 1.25, name: 'buttermilk', unitCategory: 1 }],
            ['2 (6 ounce) cans tomatoes', { id: 0, quantity: 6, name: 'tomato', unitCategory: 2 }],
        ];
        it('Should correctly parse an ingredient description', () => {
            cases.forEach(([ingredient, result]) => expect(parse(ingredient)).toEqual(result));
        });
    });
});
