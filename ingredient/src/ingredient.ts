import { json, urlencoded } from 'body-parser';
import * as express from 'express';
import * as http from 'http';
import { masterRouter } from './routes/_master-routes';

const app = express();
const service = http.createServer(app);

app.use(json());
app.use(urlencoded({ extended: true }));
app.use('/', masterRouter);

module.exports = service;
