"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const express_1 = __importDefault(require("express"));
const mongoose_1 = __importDefault(require("mongoose"));
// Import routes
const body_parser_1 = __importDefault(require("body-parser"));
const routes_1 = require("./routes/routes");
const PORT = process.env.PORT || 3000;
const DB_CONNECTION_STRING = process.env.DB_CONNECTION || 'mongodb://localhost:27017/test';
const app = express_1.default();
// middle wares
app.use(body_parser_1.default.json());
app.use(body_parser_1.default.urlencoded({ extended: true }));
// initialize the recipe routes
routes_1.initializeRecipeRoutes(app);
// Connect to DB
mongoose_1.default
    .connect(DB_CONNECTION_STRING, { useUnifiedTopology: true, useNewUrlParser: true })
    .then(() => console.log('Connected to MongoDB!'));
try {
    app.listen(PORT);
    console.log(`Server listening on port ${PORT}`);
}
catch (e) {
    console.error(e);
    throw e;
}
