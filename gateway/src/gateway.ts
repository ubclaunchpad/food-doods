import * as express from 'express';

const gateway = express();
const PORT = process.env.GATEWAY_PORT;

gateway.use(express.json());

gateway.get('/', (req, res) => {
    res.send('Gateway service endpoint');
});

gateway.listen(PORT, () => {
    console.log(`[Gateway] running on port ${PORT}`);
});
