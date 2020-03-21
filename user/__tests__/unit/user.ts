import jwt from 'jsonwebtoken';
import { getUserToken } from '../../src/controllers/user';
import { connect } from '../../src/models';
import { AuthorizationError } from '../../src/util/errors/AuthorizationError';

// NOTE: these tests assume the existence of specific users in the db
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
    it('should return requested fields if user with username exists', () => {});
    it('should not return requested fields if user with username does not exist', () => {});
});
