import 'dotenv/config';
import express from 'express';
import { IController } from './controllers/IController';
import { UserController } from './controllers/UserController';

const PORT: string = process.env.PORT || '8000';

const app: express.Application = express();
app.use(express.json());

/* initialize controllers and routes */
const userController: IController = new UserController('/user');
userController.initializeRoutes();

/* connect routers */
app.use('/', userController.router);

app.listen(PORT, () => {
    console.log('This app is listening on the port ' + PORT + '!');
});
