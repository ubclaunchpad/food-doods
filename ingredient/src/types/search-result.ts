import { ISearchResultItem } from './search-result-item';

export interface ISearchResult {
    text: string;
    parsed: ISearchResultItem[];
    hints: ISearchResultItem[];
}
