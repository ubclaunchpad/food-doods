import { Request, Response, Router } from 'express';
import { body, ValidationChain, validationResult } from 'express-validator';
import { User } from '../models/User';
import { UserManager } from '../models/UserManager';
import { IController } from './IController';

class UserController implements IController {
    public path: string;
    public router: Router;
    public userManager: UserManager;
    private userValidator: ValidationChain[] = [
        body('email')
            .not()
            .isEmpty()
            .withMessage('E-mail must be non-empty.')
            .isEmail()
            .withMessage('Must be a valid e-mail.'),
        body('username')
            .not()
            .isEmpty()
            .withMessage('Username must be non-empty.')
            .isLength({ min: 6, max: 20 })
            .withMessage('Username must be between 6 and 20 characters.'),
        body('password')
            .not()
            .isEmpty()
            .withMessage('Password must be non-empty.')
            .isLength({ min: 6, max: 20 })
            .withMessage('Password must be between 6 and 20 characters.'),
        body('fullName')
            .not()
            .isEmpty()
            .withMessage('Full name must be non-empty.')
            .custom((value: string) => {
                return /^[a-z ,.'-]+$/i.test(value);
            })
            .withMessage('Full name must be specified.'),
    ];

    public constructor(path: string) {
        this.path = path;
        this.router = Router();
        this.userManager = new UserManager();
    }

    public initializeRoutes(): void {
        this.router.post(this.path, this.userValidator, this.postUser);
        this.router.post(this.path + '/login', this.postUserLogin);
        this.router.get(this.path, this.getUser);
    }

    public postUser = async (req: Request, res: Response): Promise<Response> => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(422).json({ errors: errors.array() });
        }

        const { email, username, password, fullName, dateOfBirth, city, province, country } = req.body;
        const user: any = { email, username, password, fullName, dateOfBirth, location: { city, province, country } };

        const newUser: User = new User(user);
        return this.userManager
            .registerUser(newUser)
            .then((token: string) => {
                return res
                    .status(201)
                    .set('token', token)
                    .send({ message: 'Successfully registered!' });
            })
            .catch((err: any) => {
                return res.status(422).json({ err });
            });
    };

    public postUserLogin = async (req: Request, res: Response): Promise<Response> => {
        const { username, password } = req.body;
        const token: any = req.header('token');

        console.log(username);
        console.log(password);
        console.log(token);
        return this.userManager
            .verifyUser(username, password, token)
            .then((newToken: string | false) => {
                if (newToken) {
                    return res
                        .status(200)
                        .set('token', newToken)
                        .send({ message: 'Successfully logged in.' });
                } else {
                    return res.status(401).json({ message: 'Authorization denied.' });
                }
            })
            .catch((err: any) => {
                console.log('err');
                return res.status(422).json({ err });
            });
    };

    public getUser = async (req: Request, res: Response): Promise<Response> => {
        const { username } = req.body;
        const token: any = req.header('token');

        if (token) {
            return this.userManager
                .loginWithToken(token)
                .then((newToken: string | false) => {
                    if (newToken) {
                        return res
                            .status(200)
                            .set('token', newToken)
                            .send({ message: 'Successfully logged in.' });
                    } else {
                        return res.status(401).json({ message: 'Authorization denied.' });
                    }
                })
                .catch((err: any) => {
                    return res.status(422).json({ err });
                });
        } else {
            const user: User = this.userManager.findUser(username);
            const { requestedFields } = req.body;

            const results: any = {};
            for (const field of requestedFields) {
                const value: any = user.getDocument().get(field);
                if (value) {
                    results[field] = value;
                }
            }

            if (Object.keys(results).length > 0) {
                results[username] = username;
                return res.status(200).send({ attributes: results });
            } else {
                return res.status(404).json({ message: 'Requested attributes could not be found.' });
            }
        }
    };
}

export { UserController };
