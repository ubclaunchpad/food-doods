describe('getUserToken', () => {
    it('should throw AuthorizationError if jwt token not matching', () => {});
    it('should throw AuthorizationError if jwt token expired', () => {});
    it('should throw AuthorizationError if user does not exist', () => {});
    it('should throw AuthorizationError if has jwt token of a different user', () => {});
    it('should return new jwt token if credentials match', () => {});
});

describe('getUserAttributes', () => {
    it('should return requested fields if user with username exists', () => {});
    it('should not return requested fields if user with username does not exist', () => {});
});
