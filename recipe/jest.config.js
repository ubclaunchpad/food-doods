module.exports = {
    moduleFileExtensions: ['ts', 'tsx', 'js', 'json'],
    preset: 'ts-jest',
    testEnvironment: 'node',
    testRegex: '(/__tests__/.*|\\.(test|spec))\\.(ts|tsx|js)$',
    transform: {
        '.(ts|tsx)': 'ts-jest',
    },
};
