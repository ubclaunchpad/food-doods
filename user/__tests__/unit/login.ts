import jwt, { TokenExpiredError } from 'jsonwebtoken';
import { Document } from 'mongoose';
import { connect } from '../../src/db';
import { AuthenticationError } from '../../src/util/errors/AuthenticationError';
import { AuthorizationError } from '../../src/util/errors/AuthorizationError';
import { findUser, verifyUser } from '../../src/util/user';

// NOTE: these tests assume the existence of specific users in the db
describe('POST /user/login', () => {
    beforeEach(() => connect());

    describe('verifyUser', () => {
        it('should return new token if username and password match', async () => {
            const user: any = {
                username: 'test',
                password: 'password',
            };
            const payload: object = { username: user.username, iat: Date.now() };
            const token: string = jwt.sign(payload, process.env.JWT_SECRET_KEY as string, { expiresIn: '168h' });

            return verifyUser(user.username, user.password, token)
                .then(async (newToken: string) => {
                    const newUser: Document = await findUser(user.username);
                    expect(newToken).not.toEqual(token);
                    expect(newToken).toEqual(newUser.get('token'));
                })
                .catch((error: Error) => {
                    fail('should not have thrown error: ' + error.message);
                });
        });

        it('should throw AuthorizationError if username does not match any user', async () => {
            const user: any = {
                username: 'does_not_exist',
                password: 'password',
            };
            const payload: object = { username: user.username, iat: Date.now() };
            const token: string = jwt.sign(payload, process.env.JWT_SECRET_KEY as string, { expiresIn: '168h' });

            return verifyUser(user.username, user.password, token)
                .then(() => {
                    fail('should have thrown AuthorizationError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(AuthorizationError);
                    expect(error.message).toEqual('User could not be found.');
                });
        });

        it('should throw AuthenticationError if password does not match', async () => {
            const user: any = {
                username: 'test',
                password: 'this-is-the-wrong-password',
            };
            const payload: object = { username: user.username, iat: Date.now() };
            const token: string = jwt.sign(payload, process.env.JWT_SECRET_KEY as string, { expiresIn: '168h' });

            return verifyUser(user.username, user.password, token)
                .then(() => {
                    fail('should have thrown AuthenticationError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(AuthenticationError);
                    expect(error.message).toEqual('User could not be authenticated.');
                });
        });

        it('should assign new token if jwt token expired but username and password match', async () => {
            const user: any = {
                username: 'test',
                password: 'password',
            };
            const payload: object = { username: user.username, iat: 0 };
            const token: string = jwt.sign(payload, process.env.JWT_SECRET_KEY as string, { expiresIn: '-1' });

            return verifyUser(user.username, user.password, token)
                .then(async (newToken: string) => {
                    const newUser: Document = await findUser(user.username);
                    expect(newToken).not.toEqual(token);
                    expect(newToken).toEqual(newUser.get('token'));
                })
                .catch((error: Error) => {
                    fail('should not have thrown error: ' + error.message);
                });
        });

        it('should throw TokenExpiredError if jwt token expired and password does not match', async () => {
            const user: any = {
                username: 'test',
                password: 'this-is-the-wrong-password',
            };
            const payload: object = { username: user.username, iat: 0 };
            const token: string = jwt.sign(payload, process.env.JWT_SECRET_KEY as string, { expiresIn: '-1' });

            return verifyUser(user.username, user.password, token)
                .then(() => {
                    fail('should have thrown TokenExpiredError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(TokenExpiredError);
                    expect(error.message).toEqual('jwt expired');
                });
        });
    });
});
