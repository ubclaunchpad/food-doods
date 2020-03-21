module.exports = {
    moduleFileExtensions: ['ts', 'tsx', 'js', 'json'],
    testPathIgnorePatterns: ['<rootDir>/build'],
    preset: 'ts-jest',
    testEnvironment: 'node',
    testRegex: '(/__tests__/.*|\\.(test|spec))\\.(ts|tsx|js)$',
    transform: {
        '.(ts|tsx)': 'ts-jest',
    },
};
