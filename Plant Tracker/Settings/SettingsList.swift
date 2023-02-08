// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  SettingsList.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

// Stores a Settings class and holds functions to load and save setting data
class SettingsList : ObservableObject {
	@Published var settings = Settings() {
		didSet {
			let encoder = JSONEncoder()
			if let encoded = try? encoder.encode(settings) {
				UserDefaults.standard.set(encoded, forKey: "savedSettings")
			}
		}
	}
	
	init() {
		loadData()
	}
	
	// Loads settings from UserDefaults
	func loadData() {
		if let savedSettings = UserDefaults.standard.data(forKey: "savedSettings") {
			if let decodedSettings = try? JSONDecoder().decode(Settings.self, from: savedSettings) {
				settings = decodedSettings
				return
			}
		}
		return
	}
	
	// Saves settings to UserDefaults
	func save() {
		if let encoded = try? JSONEncoder().encode(settings) {
			UserDefaults.standard.set(encoded, forKey: "savedSettings")
			print("saved")
		}
	}
}
