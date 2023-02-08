// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  Settings.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

// Settings class
class Settings : Codable {
	var measurementType : Int = 0
	var tempType : Int = 0
	
	// Returns the correct Measurement identifier
	func translateMeasureKey() -> String {
		if self.measurementType == 0 {
			return "m"
		} else {
			return "cm"
		}
	}
	
	// Returns the correct Temperature identifier
	func translateTempKey() -> String {
		if self.tempType == 0 {
			return "F"
		} else {
			return "C"
		}
	}
}
	
