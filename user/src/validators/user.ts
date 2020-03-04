import { body, ValidationChain } from 'express-validator';

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

export { userValidator };
