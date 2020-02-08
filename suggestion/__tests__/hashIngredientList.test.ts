import { hashIngredientList } from '../src/util/hashIngredientList';

/*
 * This is used while migrating to ts-jest. Remove it after basic unit tests have been implemented.
 */

// 
test('HashIngredientList Test', () => {
    expect(hashIngredientList([0, 1, 4, 7])).toBe('10010011');
    expect(hashIngredientList([0, 2, 6, 15])).toBe('1000000001000101');
    expect(hashIngredientList([])).toBe('');
    expect(hashIngredientList([0, 1, 2, 3, 4, 5, 6, 7, 8])).toBe('111111111');
    expect(hashIngredientList([0, 1, 3, 4, 6, 7, 8])).toBe('111011011');
    expect(hashIngredientList([0, 2, 2, 2, 2, 2])).toBe('101');
    expect(hashIngredientList([0, 4, -1, -2, -3, -100, 1, 8, 4, 7, 5])).toBe('110110011');
});
