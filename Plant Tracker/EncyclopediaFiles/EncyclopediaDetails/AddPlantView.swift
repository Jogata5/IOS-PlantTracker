// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  AddPlantView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

// View to Add Plants to MyPlants
struct AddPlantView : View {
	@Environment(\.dismiss) var dismiss
	let plant: Plant
	let locationTypes = ["Indoor", "Outdoor"]
	let recurrenceOptions = ["Daily", "Every Other Day", "Weekly" ]
	
	@ObservedObject var myPlants = MyPlants()
	@State var myPlant = MyPlant()
	
	@State private var selectedTime = Date.now
	@State private var selectedRecurrence = "Daily"
	@State private var selectedLocationType = "Indoor"

	var body: some View {
		Form {
			Section {
				Picker("Location of Plant", selection: $selectedLocationType) {
					ForEach(locationTypes, id: \.self) { type in
						Text(type)
					}
				}
			}
			Section {
				DatePicker("Time to Water", selection: $selectedTime, in: Date.now..., displayedComponents: .hourAndMinute)
			}
			
			Button("Submit") {
				addToMyPlants()
				dismiss()
			}
		}
	}
	// Adds Plant to MyPlants Array
	func addToMyPlants() {
		myPlant.plant = plant
		myPlant.locationType = selectedLocationType
		myPlant.timerStart = Date.now
		myPlant.timerEnd = selectedTime
		
		myPlants.loadData()
		myPlants.myPlants.append(myPlant)
		myPlants.save()
	}
}

