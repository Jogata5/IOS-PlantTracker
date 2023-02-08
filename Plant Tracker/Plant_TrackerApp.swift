//
//  Plant_TrackerApp.swift
//  Plant Tracker
//
//  Created by csuftitan on 11/15/22.
//

import SwiftUI
import UserNotifications

@main
struct Plant_TrackerApp: App {
	@AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
				.preferredColorScheme(isDarkMode ? .dark : .light)
		}
	}
}
