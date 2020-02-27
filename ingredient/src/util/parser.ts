import { IIngredient, ISearchResult, ISearchResultItem } from '../types/_master-types';

export const parseResults = (searchResult: ISearchResult): IIngredient[] => {
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
