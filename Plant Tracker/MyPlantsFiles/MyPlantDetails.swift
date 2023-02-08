// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  MyPlantDetails.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

// MyPlant Detail View
struct MyPlantDetailView : View {
	let myPlant: MyPlant
	let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

	@ObservedObject var myPlants = MyPlants()
	@State private var showingAlert = false
	@State private var showingEntry = false
	@State private var timeRemaining : Int = 100


	var body: some View {
		ScrollView {
			// Shows Infomation from the Encyclopedia on the respective plant
			PlantDetailView(plant: myPlant.plant)
			VStack {
				Spacer()
				Text(myPlant.locationType)
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.blue.opacity(0.75))
					.clipShape(Capsule())
				// Display the time when the plant needs to be watered
				Text("Water @: \(myPlant.timerEnd)")
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.blue.opacity(0.75))
					.clipShape(Capsule())
				Spacer()
			}
		}
	}
}
