// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  MyPlants.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/13/22.
//

import SwiftUI

// holds the list of MyPlants
class MyPlants : ObservableObject {
	@Published var myPlants = [MyPlant]() {
		didSet {
			let encoder = JSONEncoder()
			
			if let encoded = try? encoder.encode(myPlants) {
				UserDefaults.standard.set(encoded, forKey: "savedMyPlants")
			}
		}
	}
	
	init() {
		loadData()
	}
	
	// Loads MyPlant list from UserDefaults
	func loadData() {
		if let savedMyPlants = UserDefaults.standard.data(forKey: "savedMyPlants") {
			if let decodedPlants = try? JSONDecoder().decode([MyPlant].self, from: savedMyPlants) {
				myPlants = decodedPlants
				return
			}
		}
		myPlants = []
	}
	
	// Saves MyPlant list to userDefaults
	func save() {
		if let encoded = try? JSONEncoder().encode(myPlants) {
			UserDefaults.standard.set(encoded, forKey: "savedMyPlants")
		}
	}
	
	// Updates each plant's water cycle start and end times
	func updateTimes() {
		for myPlant in myPlants {
			myPlant.updateTime()
		}
	}
}
