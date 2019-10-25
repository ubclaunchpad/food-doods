import { json, urlencoded } from 'body-parser';
import * as dotenv from 'dotenv';
import * as express from 'express';
import { db } from './db';

dotenv.config();

const app = express();

app.use(json());
app.use(urlencoded({ extended: true }));

// test query
app.get('/', (_, res) => {
    db.query('SELECT * from test', (error, results) => {
        if (error) {
            res.status(500).send('Internal server error');
        }
        res.status(200).json(results.rows);
    });
});

app.listen(3000, () => {
    console.log('Server listening on port 3000');
});
