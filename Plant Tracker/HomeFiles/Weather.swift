// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  Weather.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/16/22.
//

import SwiftUI
import WeatherKit
import CoreLocation

// Allows WeatherKit to be used
@MainActor class WeatherKitManager: ObservableObject {
	@Published var weather: Weather?
	
	// Gets the weather according to location
	func getWeather(latitude: Double, longitude: Double) async {
			do {
				weather = try await Task.detached(priority: .userInitiated) {
					return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
				}.value
			} catch {
				print((error))
			}
		}
	
	// Gets the symbol that corressponds to the current weather
	var symbol: String {
			weather?.currentWeather.symbolName ?? "xmark"
		}
	
	// Gets the temperature
	var temp: String {
			let temp =
			weather?.currentWeather.temperature
			
			let convert = temp?.converted(to: .fahrenheit).description
			return convert ?? "Loading Weather Data"
			
		}
}
