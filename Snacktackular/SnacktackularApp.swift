//
//  SnacktackularApp.swift
//  Snacktackular
//
//  Created by Zicount on 10.02.23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		
		return true
	}
}

@main
struct SnacktackularApp: App {
	// register app delegate for Firebase setup
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
	@StateObject var spotVM = SpotViewModel()
	
    var body: some Scene {
        WindowGroup {
            LoginView()
				.environmentObject(spotVM)
        }
    }
}
