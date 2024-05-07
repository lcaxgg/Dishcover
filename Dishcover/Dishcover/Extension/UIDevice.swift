//
//  UIDevice.swift
//  Dishcover
//
//  Created by j8bok on 5/7/24.
//

import Foundation
import SwiftUI

extension UIDevice {
    static var hasNotch: Bool {
        var hasNotch = false
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            hasNotch = window.safeAreaInsets.bottom > 0
        }
        
        return hasNotch
    }
}
