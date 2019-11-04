import 'dotenv/config';
import express, { Application } from 'express';
import { router as userRouter } from './controllers/user';

const PORT: string = process.env.PORT || '8000';

const app: Application = express();
app.use(express.json());

/* connect routers */
app.use('/', userRouter);

app.listen(PORT, () => {
    console.log('This app is listening on the port ' + PORT + '!');
});
