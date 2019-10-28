import { Pool } from 'pg';

export const db = new Pool({
    user: process.env.DB_USER || 'me',
    host: process.env.DB_HOST || 'localhost',
    database: process.env.DB_NAME || 'fooddoodsingredient',
    password: process.env.DB_PASSWORD || 'password',
    port: Number(process.env.DB_PORT) || 5432,
});
