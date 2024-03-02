//
//  FoodGrabApp.swift
//  FoodGrab
//
//  Created by jayvee on 8/30/23.
//

import SwiftUI

@main
struct FoodGrabApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            Meals()
        }
    }
}
