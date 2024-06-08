//
//  NavigationBarTitleEnum.swift
//  Dishcover
//
//  Created by j8bok on 3/29/24.
//

import Foundation

enum NavigationBarTitleEnum: Int {
    case mealsNavTitle
    case chatNavTitle
    case accountNavTitle
}

enum NavigationViewItemEnum: Int {
    case none
    case welcome
    case login
    case register
    case chat
}

enum NavigationRoute: Hashable {
    case register
    case login
    case base
}

