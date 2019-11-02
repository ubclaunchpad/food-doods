import express from 'express';

interface IController {
    path: string;
    router: express.Router;

    initializeRoutes(): void;
}

export { IController };
