import express from 'express';
import mongoose from 'mongoose';

// Import routes
import bodyParser from 'body-parser';
import { initializeUserRoutes } from './routes/routes';

const PORT = process.env.USER_PORT || 8000;
const DB_CONNECTION_STRING = process.env.USER_DB_CONNECTION || 'mongodb://localhost:27017/test';
const app = express();

// middle wares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// initialize the User routes
initializeUserRoutes(app);

// Connect to DB
mongoose
    .connect(DB_CONNECTION_STRING, { useUnifiedTopology: true, useNewUrlParser: true, useCreateIndex: true })
    .then(() => console.log('Connected to MongoDB!'));

try {
    app.listen(PORT);
    console.log(`Server listening on port ${PORT}`);
} catch (e) {
    console.error(e);
    throw e;
}
