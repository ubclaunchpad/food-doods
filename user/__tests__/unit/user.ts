import bcrypt from 'bcrypt';
import jwt, { JsonWebTokenError, TokenExpiredError } from 'jsonwebtoken';
import { Document } from 'mongoose';
import { AVAILABLE_FIELDS, createUser, findUser, getUserAttributes, getUserToken } from '../../src/controllers/user';
import { connect } from '../../src/db';
import { LocationModel } from '../../src/models/location';
import { UserModel } from '../../src/models/user';
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
                    fail('should have failed with TokenExpiredError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(TokenExpiredError);
                    expect(error.message).toEqual('jwt expired');
                });
        });

        it('should throw AuthorizationError if incorrect secret key', async () => {
            const testUser = { username: 'test' };
            const payload: object = { username: testUser.username, iat: Date.now() };
            const token: string = jwt.sign(payload, 'secret-key', { expiresIn: '168h' });
            return getUserToken(token)
                .then(() => {
                    fail('should have failed with JsonWebTokenError');
                })
                .catch((error: Error) => {
                    expect(error).toBeInstanceOf(JsonWebTokenError);
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
        beforeEach(() => connect());

        afterEach(async () => {
            await UserModel.deleteOne({ email: 'test123@gmail.com' });
            await UserModel.deleteOne({ email: 'test456@gmail.com' });
            return LocationModel.deleteOne({ city: 'TestCity' });
        });

        it('should create user with valid required fields', async () => {
            const user: any = {
                email: 'test123@gmail.com',
                username: 'username',
                password: 'password',
                fullName: 'John Smith',
            };

            return createUser(user)
                .then(async (expectedToken: string) => {
                    const userMatchingUsername: Document = await findUser(user.username);
                    const { email, username, password, fullName, token } = userMatchingUsername.toObject();
                    expect(email).toEqual(user.email);
                    expect(username).toEqual(user.username);
                    expect(bcrypt.compare(password, user.password)).toBeTruthy();
                    expect(fullName).toEqual(user.fullName);
                    expect(token).toEqual(expectedToken);
                })
                .catch((error: Error) => {
                    fail('should not have failed: ' + error.message);
                });
        });

        it('should not create user with missing email', async () => {
            const user: any = {
                username: 'username',
                password: 'password',
                fullName: 'John Smith',
            };

            return createUser(user)
                .then(() => {
                    fail('should have thrown an error');
                })
                .catch((error: Error) => {
                    expect(error.message).toMatch(/Path `email` is required./i);
                });
        });

        it('should not create user with missing username', async () => {
            const user: any = {
                email: 'test123@gmail.com',
                password: 'password',
                fullName: 'John Smith',
            };

            return createUser(user)
                .then(() => {
                    fail('should have thrown an error');
                })
                .catch((error: Error) => {
                    expect(error.message).toMatch(/Path `username` is required./i);
                });
        });

        it('should not create user with missing password', async () => {
            const user: any = {
                email: 'test123@gmail.com',
                username: 'username',
                fullName: 'John Smith',
            };

            return createUser(user)
                .then(() => {
                    fail('should have thrown an error');
                })
                .catch((error: Error) => {
                    expect(error.message).toMatch(/data and salt arguments required/i);
                });
        });

        it('should not create user with missing fullName', async () => {
            const user: any = {
                email: 'test123@gmail.com',
                username: 'username',
                password: 'password',
            };

            return createUser(user)
                .then(() => {
                    fail('should have thrown an error');
                })
                .catch((error: Error) => {
                    expect(error.message).toMatch(/Path `fullName` is required./i);
                });
        });

        it('should not create two users with the same email', async () => {
            const userOne: any = {
                email: 'test123@gmail.com',
                username: 'username',
                password: 'password',
                fullName: 'John Smith',
            };
            const userTwo: any = {
                email: 'test123@gmail.com',
                username: 'another_username',
                password: 'another_password',
                fullName: 'Dan Lee',
            };

            return createUser(userOne)
                .then(async () => {
                    return createUser(userTwo)
                        .then(() => {
                            fail('should have thrown error');
                        })
                        .catch((error: Error) => {
                            expect(error.message).toMatch(/duplicate key error/i);
                        });
                })
                .catch((error: Error) => {
                    fail('should not have thrown error: ' + error.message);
                });
        });

        it('should not create two users with the same username', async () => {
            const userOne: any = {
                email: 'test123@gmail.com',
                username: 'username',
                password: 'password',
                fullName: 'John Smith',
            };
            const userTwo: any = {
                email: 'test456@gmail.com',
                username: 'username',
                password: 'another_password',
                fullName: 'Dan Lee',
            };

            return createUser(userOne)
                .then(async () => {
                    return createUser(userTwo)
                        .then(() => {
                            fail('should have thrown error');
                        })
                        .catch((error: Error) => {
                            expect(error.message).toMatch(/duplicate key error/i);
                        });
                })
                .catch((error: Error) => {
                    fail('should not have thrown error: ' + error.message);
                });
        });

        it('should create user with all fields', async () => {
            const user: any = {
                email: 'test123@gmail.com',
                username: 'username',
                password: 'password',
                fullName: 'John Smith',
                dateOfBirth: new Date(2000, 1, 1),
                location: {
                    city: 'TestCity',
                    province: 'TC',
                    country: 'Country',
                },
            };

            return createUser(user)
                .then(async (expectedToken: string) => {
                    const userMatchingUsername: any = await UserModel.findOne({ username: user.username });
                    const { email, username, password, fullName, token, location } = userMatchingUsername.toObject();
                    const locationMatchingUser: any = await LocationModel.findById(location).lean();
                    if (locationMatchingUser) {
                        delete locationMatchingUser.__v;
                        delete locationMatchingUser._id;
                    }
                    expect(email).toEqual(user.email);
                    expect(username).toEqual(user.username);
                    expect(bcrypt.compare(password, user.password)).toBeTruthy();
                    expect(fullName).toEqual(user.fullName);
                    expect(token).toEqual(expectedToken);
                    expect(locationMatchingUser).toEqual(user.location);
                })
                .catch((error: Error) => {
                    fail('should not have failed: ' + error.message);
                });
        });

        it('should not create user with location but missing location fields', async () => {
            const user: any = {
                email: 'test123@gmail.com',
                username: 'username',
                password: 'password',
                fullName: 'John Smith',
                location: {
                    city: 'Test City',
                    province: 'TC',
                    country: 'Country',
                },
            };

            const missingCity: any = { ...user };
            delete missingCity.location.city;
            const missingProvince: any = { ...user };
            delete missingCity.location.province;
            const missingCountry: any = { ...user };
            delete missingCity.location.country;

            return createUser(missingCity)
                .then(() => {
                    fail('should have thrown error');
                })
                .catch((error: Error) => {
                    expect(error.message).toEqual('Missing location fields.');
                    return createUser(missingProvince);
                })
                .then(() => {
                    fail('should have thrown error');
                })
                .catch((error: Error) => {
                    expect(error.message).toEqual('Missing location fields.');
                    return createUser(missingCountry);
                })
                .then(() => {
                    fail('should have thrown error');
                })
                .catch((error: Error) => {
                    expect(error.message).toEqual('Missing location fields.');
                });
        });

        it('should not duplicate location already in database', async () => {
            const userOne: any = {
                email: 'test123@gmail.com',
                username: 'username',
                password: 'password',
                fullName: 'John Smith',
                location: {
                    city: 'Test City',
                    province: 'TC',
                    country: 'Country',
                },
            };
            const userTwo: any = {
                email: 'test456@gmail.com',
                username: 'another_username',
                password: 'another_password',
                fullName: 'Dan Lee',
                location: {
                    city: 'Test City',
                    province: 'TC',
                    country: 'Country',
                },
            };

            return createUser(userOne)
                .then(async (token: string) => {
                    const user: Document = await findUser(userOne.username);
                    expect(token).toEqual(user.get('token'));
                    expect(user.get('location')).not.toBeNull();
                    return createUser(userTwo);
                })
                .then(async (token: string) => {
                    const user: Document = await findUser(userTwo.username);
                    expect(token).toEqual(user.get('token'));
                    expect(user.get('location')).not.toBeNull();
                    const location: Document[] = await LocationModel.find(userTwo.location);
                    expect(location.length).toEqual(1);
                })
                .catch((error: Error) => {
                    fail('should not have thrown error: ' + error.message);
                });
        });
    });
});
