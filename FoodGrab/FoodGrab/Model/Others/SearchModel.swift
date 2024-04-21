//
//  SearchModel.swift
//  FoodGrab
//
//  Created by j8bok on 2/29/24.
//

import Foundation
import SwiftUI

struct SearchModel {
    var searchText: String = AppConstants.emptyString
    var isSearching: Bool = false
    var isSearchFieldFocused: Bool = false
}
