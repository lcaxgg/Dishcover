//
//  SearchViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 3/2/24.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var searchModel: SearchModel
    
    init() {
        searchModel = SearchModel()
    }
    
    // MARK: - GETTER
    
    func getSearchText() -> Binding<String> {
        return Binding {
            self.searchModel.searchText
        } set: { newValue in
            self.searchModel.searchText = newValue
        }
    }
    
    func getIsSearching() -> Bool {
        searchModel.isSearching
    }
    
    func getIsSearchFieldFocused() -> Binding<Bool> {
        return Binding {
            self.searchModel.isSearchFieldFocused
        } set: { newValue in
            self.searchModel.isSearchFieldFocused = newValue
        }
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
