import { Request, Response, Router } from 'express';
import { body, ValidationChain, validationResult } from 'express-validator';
import { User } from '../models/User';
import { findUser, loginWithToken, registerUser, verifyUser } from '../models/userManager';

const router: Router = Router();

const userValidator: ValidationChain[] = [
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

const postUser = async (req: Request, res: Response): Promise<Response> => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }

    const { email, username, password, fullName, dateOfBirth, city, province, country } = req.body;
    const user: any = { email, username, password, fullName, dateOfBirth, location: { city, province, country } };

    const newUser: User = new User(user);
    return registerUser(newUser)
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

const postUserLogin = async (req: Request, res: Response): Promise<Response> => {
    const { username, password } = req.body;
    const token: any = req.header('token');

    return verifyUser(username, password, token)
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
};

const getUser = async (req: Request, res: Response): Promise<Response> => {
    const { username } = req.body;
    const token: any = req.header('token');

    if (token) {
        return loginWithToken(token)
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
        const user: User = findUser(username);
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

router.get('/user', getUser);
router.post('/user', userValidator, postUser);
router.post('/user/login', postUserLogin);

export { router };
