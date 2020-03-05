import { readFileSync } from 'fs';
import { resolve } from 'path';
import { fetchRecipes } from '../src/util/fetchRecipes';

const hashes = JSON.parse(readFileSync(resolve('mocks/hashes.json')).toString());

describe('fetch recipes', () => {
    it('should return random hashes', () => {
        const startIndex = 100;
        const result = fetchRecipes(hashes, 25, startIndex);
        expect(result).toHaveLength(25);
        result.forEach((hash) => {
            expect(hashes.indexOf(hash)).toBeGreaterThanOrEqual(startIndex);
        });
    });

    it('should return empty array if start index is larger than dataset', () => {
        const result = fetchRecipes(hashes, 25, 2000);
        expect(result).toHaveLength(0);
    });

    it('should return entire dataset if limit is greater than dataset', () => {
        const result = fetchRecipes(hashes, 1500, 0);
        expect(result).toEqual(hashes);
    });
});
