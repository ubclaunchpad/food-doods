import { fizzBuzz } from '../src/fb';

/*
 * This is used while migrating to ts-jest. Remove it after basic unit tests have been implemented.
 */

// TODO: remove
test('FizzBuzz Test', () => {
    expect(fizzBuzz(2)).toBe('1 2 ');
    expect(fizzBuzz(3)).toBe('1 2 Fizz ');
});
