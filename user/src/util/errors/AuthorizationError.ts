class AuthorizationError extends Error {
    constructor(public message: string) {
        super();
        this.name = 'AuthorizationError';
        this.message = message;
    }
}
