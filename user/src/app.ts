import express from 'express';
import { IController } from './controllers/IController';

class App {
    private app: express.Application;
    private port: string;

    constructor(port: string) {
        this.app = express();
        this.port = port;

        this.app.use(express.json());
    }

    public initializeControllers(controllers: Array<IController>): void {
        for (const controller of controllers) {
            controller.initializeRoutes();
            this.app.use('/', controller.router);
        }
    }

    public listen(): void {
        this.app.listen(this.port, () => {
            console.log('This app is listening on the port ' + this.port + '!');
        });
    }
}

export { App };
