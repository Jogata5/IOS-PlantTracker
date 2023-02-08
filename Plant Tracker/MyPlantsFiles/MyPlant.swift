// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  MyPlant.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

// Holds the MyPlant object class
class MyPlant : Codable, Identifiable, Hashable {
	static func == (lhs: MyPlant, rhs: MyPlant) -> Bool {
		return lhs.id == rhs.id
			&& lhs.plant == rhs.plant
			&& lhs.locationType == rhs.locationType
			&& lhs.timerStart == rhs.timerStart
			&& lhs.timerEnd == rhs.timerEnd
	}

	var id = UUID()
	var plant : Plant!
	var locationType : String!
    var timerStart : Date!
	var timerEnd : Date!
	
	// Allows class to be hashable
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	// Calculates the time until the next watering of the plant
	func calculatePlantTimer() -> Int {
		if self.timerStart != nil && self.timerEnd != nil {
			if self.timerStart < self.timerEnd {
				let interval = Int(DateInterval(start: self.timerStart, end: self.timerEnd).duration)
				return interval
			}
		}
		return 0
	}
	
	// Updates the start and end times of the watering cycle
	func updateTime() {
		if self.timerStart != nil && self.timerEnd != nil {
			if self.timerStart > self.timerEnd {
				self.timerStart = Date.now
				self.timerEnd = Calendar.current.date(byAdding: .hour, value: 24, to: self.timerStart)
			}
			else {
				self.timerStart = Date.now
			}
		}
	}
}


