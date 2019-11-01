import { Pool } from 'pg';

export const db = new Pool({
    user: process.env.POSTGRES_USER || 'me',
    host: process.env.DB_HOST || 'localhost',
    database: process.env.POSTGRES_NAME || 'fooddoodsingredient',
    password: process.env.POSTGRES_PASS || 'password',
    port: Number(process.env.POSTGRES_PORT) || 5432,
});
