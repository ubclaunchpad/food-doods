import * as pgp from 'pg-promise';

const connection = {
    user: process.env.POSTGRES_USER || 'me',
    host: process.env.POSTGRES_HOST || 'localhost',
    database: process.env.POSTGRES_DB || 'fooddoodsingredient',
    password: process.env.POSTGRES_PASS || 'password',
    port: Number(process.env.POSTGRES_PORT) || 5432,
});

export const db = pgp()(connection);
