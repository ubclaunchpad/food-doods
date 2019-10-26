import { MongoClient, Db } from "mongodb";

let _db: Db;
const uri: string = process.env.MONGODB_URI || "mongodb://localhost:27017/test";

function connect(collection: string, callback: (err?: any) => any): void {
    const client: MongoClient = new MongoClient(uri, { useUnifiedTopology: true });

    client.connect((err: any, client: MongoClient) => {
        if (err) {
            throw err;
        }

        _db = client.db(collection);
        return callback(err);
    });
}

function getDB(): Db {
    return _db;
}

export {
    connect,
    getDB
};