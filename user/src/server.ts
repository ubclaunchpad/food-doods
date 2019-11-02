import 'dotenv/config';
import { App } from './App';
import { IController } from './controllers/IController';
import { UserController } from './controllers/UserController';

const port: string = process.env.PORT || '8000';
const app: App = new App(port);
const controllers: Array<IController> = [new UserController('/user')];

app.initializeControllers(controllers);
app.listen();
