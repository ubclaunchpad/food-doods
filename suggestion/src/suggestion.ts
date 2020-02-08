import * as express from 'express';
import * as suggestionRouter from './routes/suggestion';

const suggestionService = express();
const PORT = 8585;

suggestionService.use(express.json());

suggestionService.get('/', (req, res) => {
    console.log('got request');
    res.status(200).send('Suggestion service endpoint');
});

suggestionService.use('/suggestion', suggestionRouter);

suggestionService.listen(PORT, () => {
    console.log(`[Suggestion] running on port ${PORT}`);
});

/*
============ Sample POST request ============= 

curl --header "Content-Type: application/json" \
  --request GET \
  --data '{
    "userID": "123456789",
    "queryIngredients": [
        {
            "commonName": "broccoli",
            "databaseID": 1
        },
        {
            "commonName": "beef",
            "databaseID": 5
        },
        {
            "commonName": "garlic",
            "databaseID": 13
        },
        {
            "commonName": "brown rice",
            "databaseID": 7
        }
    ]
}' \http://localhost:6000/withIngredients
  
*/
