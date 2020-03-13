import express from 'express';
import mongoose from 'mongoose';

// Import routes
import bodyParser from 'body-parser';
import { initializeRecipeRoutes } from './routes/routes';

const PORT = process.env.RECIPE_PORT;
const RECIPE_DB_CONNECTION = process.env.RECIPE_DB_CONNECTION;
const app = express();

// middle wares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// initialize the recipe routes
initializeRecipeRoutes(app);

// Connect to DB
mongoose
    .connect(String(RECIPE_DB_CONNECTION), {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    })
    .then(() => console.log('Db connected...'))
    .catch(() => {
        throw new Error('Unable to connect to DB');
    });

try {
    app.listen(PORT);
    console.log(`Server listening on port ${PORT}`);
} catch (e) {
    console.error(e);
    throw e;
}
