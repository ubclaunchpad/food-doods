import { getUserToken } from '../../src/controllers/user';
import { AuthorizationError } from '../../src/util/errors/AuthorizationError';

describe('getUserToken', () => {
    it("should throw AuthorizationError if jwt token doesn't exist", async () => {
        const testUser = {
            incorrectToken: `eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.
                eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4
                iOnRydWUsImp0aSI6IjM3NmUyYTViLWI0M2YtNDliNC1iNzZmLTc5NTA2Nm
                QxNGQ5ZCIsImlhdCI6MTU3NDQ1ODI0NSwiZXhwIjoxNTc0NDYxODQ1fQ.
                P2jjsvRGgyq3GJh7nc2z51701jHllWF4EvFSP3gu0Oo`,
        };
        return getUserToken(testUser.incorrectToken)
            .then(() => {
                fail('should have failed with AuthorizationError');
            })
            .catch((err: Error) => {
                expect(err).toBeInstanceOf(AuthorizationError);
            });
    });

    it('should throw AuthorizationError if jwt token expired', () => {});
    it('should throw AuthorizationError if user does not exist', () => {});
    it('should throw AuthorizationError if has jwt token of a different user', () => {});
    it('should return new jwt token if credentials match', () => {});
});

describe('getUserAttributes', () => {
    it('should return requested fields if user with username exists', () => {});
    it('should not return requested fields if user with username does not exist', () => {});
});
