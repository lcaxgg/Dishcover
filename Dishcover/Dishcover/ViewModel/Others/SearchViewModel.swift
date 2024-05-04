//
//  SearchViewModel.swift
//  Dishcover
//
//  Created by j8bok on 3/2/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var searchModel: SearchModel
    
    init() {
        searchModel = SearchModel()
    }
}

extension SearchViewModel {
   
    // MARK: - GETTER
    
    func getIsSearching() -> Bool {
        searchModel.isSearching
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
