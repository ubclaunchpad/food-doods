const request = require('supertest');
const api = require('../../src/ingredient');

describe('Basic API Test', () => {
    it('should return a status method identifying itself as the ingredient service', async () => {
        const response = await request(api)
            .get('/')
            .send();

        expect(response.status).toEqual(200);
        expect(response.text).toEqual('Ingredient Service');
    });
});
