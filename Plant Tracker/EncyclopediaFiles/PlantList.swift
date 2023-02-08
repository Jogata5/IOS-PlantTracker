// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  Plants.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/12/22.
//

import SwiftUI

// Holds the List of all Plants
class PlantList : ObservableObject {
	@Published var plants = [Plant]() {
		didSet {
			let encoder = JSONEncoder()
			
			if let encoded = try? encoder.encode(plants) {
				UserDefaults.standard.set(encoded, forKey: "plants")
			}
		}
	}
	
	init() {
		self.loadData()
		self.sortList()
	}
	
	// Sorts Plants according to Latin name
	private func sortList() {
		self.plants.sort { $0.Latin_name < $1.Latin_name}
	}
	
	// Loads all plant data from json file
	private func loadData() {
		guard let url = Bundle.main.url(forResource: "plants", withExtension: "json")
		else {
			print("Json file not found")
			return
		}
		print(url, " json Found")
		
		let data = try? Data(contentsOf: url)
		let plants = try? JSONDecoder().decode([Plant].self, from: data!)
		
		self.plants = plants!
	}
}
