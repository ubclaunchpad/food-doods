import { json, urlencoded } from 'body-parser';
import * as dotenv from 'dotenv';
import * as express from 'express';

dotenv.config();

const app = express();

app.use(json());
app.use(urlencoded());

app.listen(3000, () => {
    console.log('Server listening on port 3000');
});
