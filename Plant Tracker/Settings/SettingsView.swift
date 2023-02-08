// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  SettingsView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

// SettingsView
struct SettingsView : View {
	@AppStorage("isDarkMode") private var isDarkMode = false
	@ObservedObject private var settings = SettingsList()
		
	@State private var measureType = 0
	@State private var tempType = 0
	
	var body: some View {
		Form {
			Section("Theme") {
				Toggle("Dark Mode", isOn: $isDarkMode)
			}
			Section("Measurement Preference") {
				HStack {
					Picker("Measure Preference", selection: $measureType) {
						Text("M").tag(0)
						Text("Cm").tag(1)
					}
					.pickerStyle(.segmented)
				}
			}
			Section("Temperature Preference") {
				HStack {
					Picker("Temperature Preference", selection: $tempType) {
						Text("F").tag(0)
						Text("C").tag(1)
					}
					.pickerStyle(.segmented)
					
				}
			}
		}
		// Loads data from UserDefaults
		.onAppear() {
			settings.loadData()
			measureType = settings.settings.measurementType
			tempType = settings.settings.tempType
		}
		// Saves data to UserDefaults
		.onDisappear() {
			settings.settings.measurementType = measureType
			settings.settings.tempType = tempType
			settings.save()

		}
	}
}
