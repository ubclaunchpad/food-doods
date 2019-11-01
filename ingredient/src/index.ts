import { json, urlencoded } from 'body-parser';
import * as express from 'express';

import { ingredientRouter } from './routes/ingredient/ingredient.router';
import { userRouter } from './routes/user/user.router';

const app = express();

const PORT = process.env.PORT || 9000;

app.use(json());
app.use(urlencoded({ extended: true }));

app.use('/ingredient/user', userRouter);
app.use('/ingredient', ingredientRouter);

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
