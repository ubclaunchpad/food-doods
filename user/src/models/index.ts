import mongoose from 'mongoose';

const uri: string = process.env.USER_DB_CONNECTION || 'mongodb://localhost:27017/test';

async function connect(callback: (err?: any) => any): Promise<any> {
    return new Promise((resolve, reject) => {
        mongoose
            .connect(uri, { useCreateIndex: true, useUnifiedTopology: true, useNewUrlParser: true })
            .then(async () => {
                resolve(await callback());
            })
            .catch((err: any) => {
                reject(err);
            });
    });
}

export { connect };
