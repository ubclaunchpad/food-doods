const express = require ('express');
const bodyParser = require ('body-parser');
const mongoose = require('mongoose');
require('dotenv/config');

const PORT = process.env.PORT;
const app = express();

//Import routes
const recipeRoutes = require('./routes/recipe/routes');

//middle wares
app.use('/recipe', recipeRoutes);
app.use(bodyParser.json());

//Connect to DB
mongoose.connect(
    process.env.DB_CONNECTION,
    { useUnifiedTopology: true, useNewUrlParser: true  }
).then(
    () => console.log('Connected to Database!')
);

app.listen(PORT, () =>
    console.log(`Server listening on port ${PORT}`),
);