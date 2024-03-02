//
//  SearchViewModel.swift
//  FoodGrab
//
//  Created by jayvee on 3/2/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var searchModel = SearchModel()
    
    // MARK: - GETTER
    
    func getSearchText() -> String {
        searchModel.searchText
    }
    
    func getIsSearching() -> Bool {
        searchModel.isSearching
    }
    
    func getTest() -> Bool {
        searchModel.isSearchFieldFocused
    }
    
    // MARK: - SETTER
    
    func setSearchText(with searchText: String) {
        searchModel.searchText = searchText
    }
    
    func setIsSearching(with isSearching: Bool) {
        searchModel.isSearching = isSearching
    }
    
    func setIsSearchFieldFocused(with isSearchFieldFocused: Bool) {
        searchModel.isSearchFieldFocused = isSearchFieldFocused
    }
}
