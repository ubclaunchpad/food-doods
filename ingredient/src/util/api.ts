import axios from 'axios';
import { stringify } from 'querystring';

const API_URL = process.env.API_BASE_URL;
const API_KEY = process.env.API_KEY;
const API_APP_ID = process.env.APP_ID;

const baseParams = {
    app_id: API_APP_ID,
    app_key: API_KEY,
};

export const search = (query: string) => {
    const encodedQuery = encodeURI(query);
    const queryParams = stringify({ ...baseParams, ingr: encodedQuery });
    const endpoint = `${API_URL}?${queryParams}`;

    return axios.get(endpoint).then((response) => response.data);
};
