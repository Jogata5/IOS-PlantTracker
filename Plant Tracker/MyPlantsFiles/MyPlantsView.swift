// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  MyPlantsView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/11/22.
//

import SwiftUI
import UserNotifications

// The MyPlants View
struct MyPlantsView: View {
	
	@ObservedObject var myPlants = MyPlants()
	@State private var clock = Date.now

	@State private var myPlantsIndoors : [MyPlant] = []
	@State private var myPlantsOutdoors : [MyPlant] = []
	@State private var searchText = ""
	@State private var showingAlert = false

	let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
	
	var body: some View {
		ZStack {
			NavigationStack {
				// List is sectioned between Indoor plants and Outdoor plants
				List {
					Section("Indoor Plants") {
						ForEach(searchResultsIndoor) { myPlant in
							NavigationLink(value: myPlant) {
								HStack {
									URLImage(urlString: myPlant.plant.img ?? "N/A")
									VStack {
										Text(myPlant.plant.Latin_name)
											.font(
												.system(size: 18, weight: .bold, design: .rounded)
											)
											.multilineTextAlignment(.leading)
										Text(myPlant.plant.checkNames() )
											.font(
												.system(size: 16)
											)
											.multilineTextAlignment(.leading)
									}
								}
								// Updates the Plant's water cycle
								.onReceive(timer) {_ in
									// When its time to water, alert and update
									if myPlant.timerEnd <= Date.now {
										showingAlert = true
										myPlant.updateTime()
										myPlants.save()
									}
								}
								// When it is time to water a plant, alerts user
								.alert(isPresented: self.$showingAlert) {
									Alert(title: Text("Water Plant"),
										  message: Text("\(myPlant.locationType) \(myPlant.plant.checkNames()) needs to be watered"),
										  dismissButton: .default(Text("Ok")))
								}
								Spacer()
							}
						}
						// For Edit Button
						.onDelete { myPlants.myPlants.remove(atOffsets: $0) }
						.onMove { myPlants.myPlants.move(fromOffsets: $0, toOffset: $1) }
						.padding(3)
					}
					.padding(3)
					
					Section("Outdoor Plants") {
						ForEach(searchResultsOutdoor, id: \.self) { myPlant in
							NavigationLink(value: myPlant) {
								HStack {
									URLImage(urlString: myPlant.plant.img ?? "N/A")
									VStack {
										Text(myPlant.plant.Latin_name)
											.font(
												.system(size: 18, weight: .bold, design: .rounded)
											)
											.multilineTextAlignment(.leading)
										Text(myPlant.plant.checkNames() )
											.font(
												.system(size: 16)
											)
											.multilineTextAlignment(.leading)
									}
								}
								// Updates the Plant's water cycle
								.onReceive(timer) {_ in
									// When its time to water, alert and update
									if myPlant.timerEnd <= Date.now {
										showingAlert = true
										myPlant.updateTime()
										myPlants.save()
									}
								}
								// When it is time to water a plant, alerts user
								.alert(isPresented: self.$showingAlert) {
									Alert(title: Text("Water Plant"),
										  message: Text("\(myPlant.plant.checkNames()) needs to be watered"),
										  dismissButton: .default(Text("Ok")))
								}
								Spacer()
							}
						}
						// For Edit Button
						.onDelete { myPlants.myPlants.remove(atOffsets: $0) }
						.onMove { myPlants.myPlants.move(fromOffsets: $0, toOffset: $1) }
					}
					.padding(3)
				}
				// Allows user to navigate to the plant's MyPlant Detail View
				.navigationTitle("Plants")
				.navigationDestination(for: MyPlant.self) { plant in
					MyPlantDetailView(myPlant: plant)
				}
				.toolbar {
					EditButton()
				}
				.searchable(text: $searchText, prompt: "Search")
				// Loads MyPlant data
				.onAppear(){
					myPlants.loadData()
				}
				// Saves MyPlant Data
				.onDisappear(){
					myPlants.save()
				}
			}
		}
	}
	
	// Filters MyPlant List to only contain User's Indoor Plants
	var searchResultsIndoor: [MyPlant] {
		if searchText.isEmpty {
			return myPlants.myPlants.filter { $0.locationType.contains("Indoor")}
		} else {
			return myPlants.myPlants.filter { $0.locationType.contains("Indoor") && $0.plant.Latin_name.contains(searchText) }
		}
	}
	
	// Filters MyPlant List to only contain User's Outdoor Plants
	var searchResultsOutdoor: [MyPlant] {
		if searchText.isEmpty {
			return myPlants.myPlants.filter { $0.locationType.contains("Outdoor")}
		} else {
			return myPlants.myPlants.filter { $0.locationType.contains("Outdoor") && $0.plant.Latin_name.contains(searchText) }
		}
	}
}
