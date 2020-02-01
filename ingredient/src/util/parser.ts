import { IIngredient } from '../types';

interface ISearchResults {
    text: string;
    parsed: ISearchResultItem[];
    hints: ISearchResultItem[];
}

interface ISearchResultItem {
    food: {
        foodId: string;
        label: string;
        category: string;
    };
}

export const parseResults = (searchResult: ISearchResults): IIngredient[] => {
    const { parsed, hints } = searchResult;
    const topResults = parsed.filter(isFood).map(parseIntoIngredient);
    const hintResults = hints.filter(isFood).map(parseIntoIngredient);
    return topResults.concat(hintResults);
};

const parseIntoIngredient = (searchResult: ISearchResultItem): IIngredient => {
    const data = searchResult.food;
    return { id: data.foodId, name: data.label, category: data.category };
};

const isFood = (item: ISearchResultItem) => {
    return item.food.category.includes('food');
};
