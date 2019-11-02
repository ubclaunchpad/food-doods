import { Pool } from 'pg';

export const db = new Pool({
    user: process.env.POSTGRES_USER || 'me',
    host: process.env.POSTGRES_HOST || 'localhost',
    database: process.env.POSTGRES_DB || 'fooddoodsingredient',
    password: process.env.POSTGRES_PASS || 'password',
    port: Number(process.env.POSTGRES_PORT) || 5432,
});
