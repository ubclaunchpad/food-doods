import jwt from 'jsonwebtoken';
import { connect } from '.';
import { User } from './User';

class UserManager {
    private listOfUsers: User[];

    constructor() {
        this.listOfUsers = [];
    }

    public async registerUser(user: User): Promise<string> {
        const callback = async (err: any): Promise<string> => {
            if (err) {
                throw err;
            }

            const token: string = user.assignNewToken();

            this.listOfUsers.push(user);
            return user
                .save()
                .then(() => {
                    return token;
                })
                .catch((error: any) => {
                    throw error;
                });
        };
        return await connect(callback);
    }

    public findUser(username: string): User {
        const user: User | undefined = this.listOfUsers.find((u: User) => {
            return u.getUsername() === username;
        });

        if (user) {
            return user;
        } else {
            throw new Error('User could not be found.');
        }
    }

    public async verifyUser(username: string, password: string, token: string): Promise<string | false> {
        const user: User = this.findUser(username);
        const passwordsMatch: boolean = await user.passwordsMatch(password);
        const secretKey: any = process.env.JWT_SECRET_KEY;

        if (secretKey) {
            try {
                const decoded: any = jwt.verify(token, secretKey, { maxAge: '168h' });
                if (decoded.username === username && passwordsMatch) {
                    return user.assignNewToken();
                }
            } catch (err) {
                switch (err.name) {
                    case 'TokenExpiredError':
                        if (passwordsMatch) {
                            return user.assignNewToken();
                        }
                    default:
                        throw err;
                }
            }
            return false;
        } else {
            throw new Error('Secret key is not defined.');
        }
    }

    public async loginWithToken(token: string) {
        const secretKey: any = process.env.JWT_SECRET_KEY;
        const decoded: any = jwt.verify(token, secretKey, { maxAge: '168h' });

        if (decoded) {
            const user = this.findUser(decoded);
            if (decoded.username === user.getUsername()) {
                return user.assignNewToken();
            }
        }
        return false;
    }
}

export { UserManager };
