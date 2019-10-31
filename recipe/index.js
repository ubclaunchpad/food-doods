"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var express_1 = __importDefault(require("express"));
var mongoose_1 = __importDefault(require("mongoose"));
require('dotenv/config');
var PORT = process.env.PORT || 3000;
var DB_CONNECTION_STRING = process.env.DB_CONNECTION || '';
var app = express_1.default();
// Import routes
var recipeRoutes = require('./routes/routes');
// middle wares
app.use('/recipe', recipeRoutes);
// Connect to DB
mongoose_1.default
    .connect(DB_CONNECTION_STRING, { useUnifiedTopology: true, useNewUrlParser: true })
    .then(function () { return console.log('Connected to Database!'); });
app.listen(PORT, function () { return console.log("Server listening on port " + PORT); });
