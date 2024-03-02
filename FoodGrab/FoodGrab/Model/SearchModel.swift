//
//  SearchModel.swift
//  FoodGrab
//
//  Created by jayvee on 2/29/24.
//

import Foundation
import SwiftUI

struct SearchModel {
    var searchText: String = AppConstants.emptyString
    var isSearching: Bool = false
}


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
    
    // MARK: - SETTER
    
    func setSearchText(with searchText: String) {
        searchModel.searchText = searchText
    }
    
    func setIsSearching(with isSearching: Bool) {
        searchModel.isSearching = isSearching
    }
}
