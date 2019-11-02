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
        console.log(this.listOfUsers.length);
        const user: User | undefined = this.listOfUsers.find((u: User) => {
            return u.getUsername() === username;
        });

        if (user) {
            return user;
        } else {
            console.log('user not found');
            throw new Error('User could not be found.');
        }
    }

    public async verifyUser(username: string, password: string, token: string): Promise<string | false> {
        console.log('find user');
        const user: User = this.findUser(username);
        console.log('getting passwords match');
        const passwordsMatch: boolean = await user.passwordsMatch(password);
        console.log('passwords match');
        const secretKey: any = process.env.JWT_SECRET_KEY;

        if (secretKey) {
            try {
                const decoded: any = jwt.verify(token, secretKey, { maxAge: '168h' });
                console.log(decoded.username);
                console.log(passwordsMatch);
                if (decoded.username === username && passwordsMatch) {
                    return user.assignNewToken();
                }
            } catch (err) {
                console.log('error found');
                switch (err.name) {
                    case 'TokenExpiredError':
                        if (passwordsMatch) {
                            return user.assignNewToken();
                        }
                    default:
                        throw err;
                }
            }
            console.log('returned false');
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
