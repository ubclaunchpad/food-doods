import { json, urlencoded } from 'body-parser';
import * as express from 'express';
import { db } from './db';

const app = express();

const PORT = process.env.PORT || 9000;

app.use(json());
app.use(urlencoded({ extended: true }));

// test query
app.get('/', (_, res) => {
    db.query('SELECT * from ingredient', (error, results) => {
        if (error) {
            return res.status(500).json(error);
        }
        res.status(200).json(results.rows);
    });
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
