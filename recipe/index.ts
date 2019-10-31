import 'dotenv/config';
import express from 'express';
import { Server } from 'http';
import mongoose from 'mongoose';

// Import routes
import { initializeRecipeRoutes } from './routes/routes';

const PORT = process.env.PORT || 3000;
const DB_CONNECTION_STRING = process.env.DB_CONNECTION || 'mongodb://localhost:27017/test';
const app = express();

// initialize the recipe routes
initializeRecipeRoutes(app);

// Connect to DB
try {
    mongoose
        .connect(DB_CONNECTION_STRING, { useUnifiedTopology: true, useNewUrlParser: true })
        .then(() => console.log('Connected to Database!'));
} catch (e) {
    console.error(e);
}

let server: Server;
try {
    server = app.listen(PORT);
    console.log(`Server listening on port ${PORT}`);
} catch (e) {
    console.error(e);
    throw e;
}
