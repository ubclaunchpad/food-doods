import { suggestRecipes } from '../src/controller/suggestRecipe';
import { hashIngredientList } from '../src/util/hashIngredientList';

describe('suggestRecipes', () => {
    it('should return exact matches if threshold is 1', () => {
        const hashes = ['1011', '1001', '0000', '0010', '1001', '1100'];
        const results = suggestRecipes([0, 1, 3], 1, hashes);
        results.forEach((result) => expect(result).toEqual(0b1011));
    });

    it('should return at most 5 matched recipes', () => {
        const hashes = Array(8).fill('1011');
        expect(suggestRecipes([0, 1, 3], 1, hashes)).toHaveLength(5);
    });

    it.only('should return no matches if no recipes exceed threshold', () => {
        const hashes = Array(8).fill('1011');
        expect(suggestRecipes([0, 1, 2], 1, hashes)).toHaveLength(0);
    });
});
