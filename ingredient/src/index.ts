import { json, urlencoded } from 'body-parser';
import * as express from 'express';

import { masterRouter } from './routes/_master-routes';

const app = express();

const PORT = process.env.PORT || 9000;

app.use(json());
app.use(urlencoded({ extended: true }));

app.use('/', masterRouter);

app.listen(PORT, () => {
    console.log(`[Ingredient] listening on port ${PORT}`);
});
