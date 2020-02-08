/*
 * This is used while migrating to ts-jest. Remove it after basic unit tests have been implemented.
 */

// TODO: remove
export function fizzBuzz(n: number): string {
    let output = '';
    for (let i = 1; i <= n; i++) {
        if (i % 5 && i % 3) {
            output += i + ' ';
        }
        if (i % 3 === 0) {
            output += 'Fizz ';
        }
        if (i % 5 === 0) {
            output += 'Buzz ';
        }
    }
    return output;
}
