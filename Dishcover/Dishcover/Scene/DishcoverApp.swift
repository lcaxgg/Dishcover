//
//  DishcoverApp.swift
//  Dishcover
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI

@main
struct DishcoverApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            Splash()
        }
    }
}
