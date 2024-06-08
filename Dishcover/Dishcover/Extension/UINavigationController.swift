//
//  UINavigationController.swift
//  Dishcover
//
//  Created by j8bok on 5/7/24.
//

import Foundation
import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        setNavigationBackButtonTitle()
    }
    
    private func getNavigationViewTitle() -> String {
        var title = String()
        
        if let tag = NavigationViewItemEnum(rawValue: NavigationViewModel.getNavigationViewItemTag()) {
            switch tag {
            case .welcome, .login, .register:
                title = AppConstants.back
            case .none, .chat:
                title = AppConstants.emptyString
            }
        }
        
        return title
    }
    
    private func setNavigationBackButtonTitle() {
        let title = getNavigationViewTitle()
        
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
}
