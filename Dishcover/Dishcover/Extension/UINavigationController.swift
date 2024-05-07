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
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: AppConstants.back, style: .plain, target: nil, action: nil)
    }
}
