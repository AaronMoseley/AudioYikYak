//
//  AudioYikYakApp.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import SwiftUI
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct AudioYikYakApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            StartView().preferredColorScheme(.light)
        }
    }
}
