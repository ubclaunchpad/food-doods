import { getQuantity, parse } from '../../src/util/parser';

describe('Parser', () => {
    describe('Parse Quantity', () => {
        const cases: Array<[string, number, string]> = [
            ['6 eggs', 6, 'Should parse a simple number at start of ingredient'],
            ['hello', null, "Should return null if ingredient doesn't start with a number"],
            ['1/4 teaspoon salt', 0.25, 'Should parse fractions'],
            ['1 1/4 cups buttermilk', 1.25, 'Should parse mixed numbers'],
            ['2 (6 ounce) cans tomatoes', 6, 'Should prioritize quantities inside brackets'],
        ];
        cases.forEach(([ingredient, quantity, message]) => {
            it(message, () => {
                expect(getQuantity(ingredient)[0]).toEqual(quantity);
            });
        });
    });
});
