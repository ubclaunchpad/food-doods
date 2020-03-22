import jwt from 'jsonwebtoken';
import { AVAILABLE_FIELDS, createUser, getUserAttributes, getUserToken } from '../../src/controllers/user';
import { connect } from '../../src/models';
import { AuthorizationError } from '../../src/util/errors/AuthorizationError';

// NOTE: these tests assume the existence of specific users in the db
describe('GET /user/:username', () => {
    describe('getUserToken', () => {
        beforeEach(() => connect());

        it('should throw AuthorizationError if jwt token expired', async () => {
            const testUser = { username: 'test' };
            const payload: object = { username: testUser.username, iat: 0 };
            const secretKey: any = process.env.JWT_SECRET_KEY;
            const expiredToken: string = jwt.sign(payload, secretKey, { expiresIn: '-1' });
            return getUserToken(expiredToken)
                .then(() => {
                    fail('should have failed with AuthorizationError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(AuthorizationError);
                    expect(error.message).toEqual('jwt expired');
                });
        });

        it('should throw AuthorizationError if incorrect secret key', async () => {
            const testUser = { username: 'test' };
            const payload: object = { username: testUser.username, iat: Date.now() };
            const token: string = jwt.sign(payload, 'secret-key', { expiresIn: '168h' });
            return getUserToken(token)
                .then(() => {
                    fail('should have failed with AuthorizationError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(AuthorizationError);
                    expect(error.message).toEqual('invalid signature');
                });
        });

        it('should throw AuthorizationError if user does not exist', async () => {
            const testUser = { username: 'does_not_exist' };
            const payload: object = { username: testUser.username, iat: Date.now() };
            const secretKey: any = process.env.JWT_SECRET_KEY;
            const token: string = jwt.sign(payload, secretKey, { expiresIn: '168h' });
            return getUserToken(token)
                .then(() => {
                    fail('should have failed with AuthorizationError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(AuthorizationError);
                    expect(error.message).toEqual('User could not be found.');
                });
        });

        it('should return new jwt token if credentials match', async () => {
            const testUser = { username: 'test' };
            const payload: object = { username: testUser.username, iat: Date.now() };
            const secretKey: any = process.env.JWT_SECRET_KEY;
            const token: string = jwt.sign(payload, secretKey, { expiresIn: '168h' });
            return getUserToken(token)
                .then((newToken: string) => {
                    expect(newToken).not.toEqual(token);
                })
                .catch((error: Error) => {
                    fail('should not have failed: ' + error.message);
                });
        });
    });

    describe('getUserAttributes', () => {
        beforeEach(() => connect());

        it('should not return requested fields if user with username does not exist', () => {
            const testUser = { username: 'does_not_exist' };
            return getUserAttributes(testUser.username)
                .then(() => {
                    fail('should have failed with AuthorizationError');
                })
                .catch((error: Error) => {
                    expect(error.message).toEqual('User could not be found.');
                });
        });

        it('should return requested fields if user with username exists', () => {
            const testUser = { username: 'test' };
            return getUserAttributes(testUser.username)
                .then((attributes: any) => {
                    const expectedFields: string[] = AVAILABLE_FIELDS;
                    const expectedValues: string[] = ['John Smith', 'test', '5e765ab44e7aa5d210c2fda5'];
                    const actualFields: string[] = Object.keys(attributes);
                    const actualValues: string[] = Object.values(attributes);
                    expect(expectedFields).toEqual(actualFields);
                    expect(expectedValues).toEqual(actualValues);
                })
                .catch((error: Error) => {
                    fail('should not have failed: ' + error.message);
                });
        });
    });
});

describe('POST /user', () => {
    describe('createUser', () => {
        it('should create user with valid required fields', () => {});
        it('should not create user with missing email', () => {});
        it('should not create user with missing username', () => {});
        it('should not create user with missing password', () => {});
        it('should not create user with missing full name', () => {});
        it('should not create two users with the same email', () => {});
        it('should not create two users with the same username', () => {});
        it('should create user with all fields', () => {});
        it('should not create user with location but missing city', () => {});
        it('should not create user with location but missing province', () => {});
        it('should not create user with location but missing country', () => {});
    });
});
