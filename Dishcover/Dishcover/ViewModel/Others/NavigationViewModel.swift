//
//  NavigationViewModel.swift
//  Dishcover
//
//  Created by j8bok on 5/7/24.
//

import Foundation

class NavigationViewModel: ObservableObject {

    // MARK: - PROPERTIES
   
    private static let sharedInstance: NavigationViewModel = NavigationViewModel()
    private var navigationModel: NavigationModel = NavigationModel(tag: NavigationViewItemEnum.none.rawValue)
    
    // MARK: - METHOD
    
    private init() {}
}

extension NavigationViewModel {
    
    // MARK: - GETTER
    
    static func getNavigationViewItemTag() -> Int {
        sharedInstance.navigationModel.tag
    }
    
    // MARK: - SETTER
    
    static func setNavigationViewItemTag(with tag: Int) {
        sharedInstance.navigationModel.tag = tag
    }
}
