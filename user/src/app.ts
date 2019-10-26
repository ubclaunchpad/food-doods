import express from "express";
import { connect, getDB } from "../data/index";

const app: express.Application = express();

const PORT: string = process.env.PORT || "8000";

app.get("/", (req, res) => {
    connect("test", () => {
        res.send("Connection successful!");
    });
});

app.listen(PORT, () => {
    console.log(`Example app listening on port ${PORT}!`);
});