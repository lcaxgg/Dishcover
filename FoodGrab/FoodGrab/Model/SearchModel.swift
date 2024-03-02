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
    var isSearchFieldFocused: Bool = false
}
