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
        setNavigationBarShadowColor()
    }
    
    private func getNavigationViewTitle() -> String {
        var title = String()
        
        if let tag = NavigationViewItemEnum(rawValue: NavigationViewModel.getNavigationViewItemTag()) {
            switch tag {
            case .login, .register:
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
    
    private func setNavigationBarShadowColor() {
//        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
//        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
//        navigationController?.navigationBar.layer.shadowRadius = 20.0
//        navigationController?.navigationBar.layer.shadowOpacity = 0.20
//        navigationController?.navigationBar.layer.masksToBounds = false
    }
}
