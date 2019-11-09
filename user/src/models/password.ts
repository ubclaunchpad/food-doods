import bcrypt from 'bcrypt';
import { Document } from 'mongoose';

const SALT_ROUNDS: number = 10;

function hashPassword(password: string): string {
    return bcrypt.hashSync(password, SALT_ROUNDS);
}

async function passwordsMatch(user: Document, password: string): Promise<boolean> {
    return bcrypt.compare(password, user.get('password'));
}

export { hashPassword, passwordsMatch };
