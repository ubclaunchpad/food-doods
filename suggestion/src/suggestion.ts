import * as express from 'express';

const gateway = express();
const PORT = 6000;

gateway.use(express.json());

gateway.get('/', (req, res) => {
    res.send('Suggestion service endpoint');
});

gateway.listen(PORT, () => {
    console.log(`[Suggestion] running on port ${PORT}`);
});
