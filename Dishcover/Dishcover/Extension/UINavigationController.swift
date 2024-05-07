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
        var title = String()
        
        if let tag = NavigationViewItemEnum(rawValue: NavigationViewModel.getNavigationViewItemTag()) {
            switch tag {
            case .login, .register:
                title = AppConstants.back
            case .none, .chat:
                title = AppConstants.emptyString
            }
        }
        
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
}
