//
//  AppDelegate.swift
//  Dishcover
//
//  Created by j8bok on 9/13/23.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
   
        configureFirebase()
        return true
    }
    
    private func configureFirebase() {
        FirebaseApp.configure()
        
        let settings = FirestoreSettings()

        settings.cacheSettings = MemoryCacheSettings(garbageCollectorSettings: MemoryLRUGCSettings())
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: 100 * 1024 * 1024 as NSNumber)
       
        let db = Firestore.firestore()
        db.settings = settings
    }
}

