import { compareHash } from '../src/util/compareHash';

describe('util/compareHash', () => {
    it('should return 0 if recipe uses no ingredients and user has no ingredients', () => {
        const emptyRecipe: number = 0;
        const emptyIngredients: number = 0;
        const score: number = compareHash(emptyRecipe, emptyIngredients);
        expect(score).toEqual(0);
    });

    it('should return 1 if user has all ingredients in recipe', () => {
        const recipeWithOneIngredient: number = 0b1000;
        const userWithOneIngredient: number = 0b1000;
        const score: number = compareHash(recipeWithOneIngredient, userWithOneIngredient);
        expect(score).toEqual(1.0);
    });

    it('should return 0.5 if user owns half of the ingredients in the recipe', () => {
        const recipeWithFourIngredients: number = 0b00101101;
        const userWithTwoIngredients: number = 0b0101;
        const score: number = compareHash(recipeWithFourIngredients, userWithTwoIngredients);
        expect(score).toEqual(0.5);
    });

    it('should return 0 if user owns no overlapping ingredients in the recipe', () => {
        const recipeWithSixIngredients: number = 0b0001010100110101;
        const userWithNoMatchingIngredients: number = 0b1110101011001010;
        const score: number = compareHash(recipeWithSixIngredients, userWithNoMatchingIngredients);
        expect(score).toEqual(0.0);
    });

    it('should return 0.55556 (rounded) if user has 5 out of 9 ingredients in the recipe', () => {
        const recipe: number = 0b1010101011001011;
        const userIngredients: number = 0b0100110111011110;
        const score: number = compareHash(recipe, userIngredients);
        expect(score).toEqual(0.55556);
    });
});
