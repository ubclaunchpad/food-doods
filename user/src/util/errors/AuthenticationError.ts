class AuthenticationError extends Error {
    constructor(public message: string) {
        super();
        this.name = 'AuthenticationError';
        this.message = message;
    }
}

export { AuthenticationError };
