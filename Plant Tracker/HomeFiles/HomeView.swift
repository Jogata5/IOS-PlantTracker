// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  HomeView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/16/22.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct HomePageView: View {
	@ObservedObject var weatherKitManager = WeatherKitManager()
	@StateObject var locationDataManager = LocationDataManager()
	
	let columns = [GridItem(.adaptive(minimum: 150))]
	let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

	@ObservedObject var myPlants = MyPlants()
	@State private var timeRemaining : Int = 100
	@State private var showingAlert = false
				
	var body: some View {
		NavigationStack {
			VStack {
				LazyVGrid(columns: columns) {
					// Outputs the User's next plant to be watered. based on time
					NavigationLink(value: getPlantToWater()) {
						if !myPlants.myPlants.isEmpty {
							VStack {
								Text("Next Plant to Water")
									.foregroundColor(.white)
									.padding(.horizontal, 20)
									.padding(.vertical, 5)
									.background(.green.opacity(0.75))
									.clipShape(RoundedRectangle(cornerRadius: 25))
								URLImage(urlString: getPlantToWater().plant.img ?? "N/A")
								Text(getPlantToWater().plant.checkNames())
								Text(convertSeconds(sec: timeRemaining))
							}
							// Countdown the timer
							.onReceive(timer) {_ in
								if timeRemaining > 0 {
									timeRemaining -= 1
								}
							}
							.foregroundColor(.white)
							.padding(.horizontal, 20)
							.padding(.vertical, 5)
							.background(.blue.opacity(0.75))
							.clipShape(RoundedRectangle(cornerRadius: 25))
						}
					}
					// Contains the Weather box which displays the weather. Only works on physical device. Does not work in simulation
					VStack {
						if locationDataManager.authorizationStatus == .authorizedWhenInUse {
							Label(weatherKitManager.temp, systemImage: weatherKitManager.symbol)
								.task {
									await weatherKitManager.getWeather(latitude: locationDataManager.latitude, longitude: locationDataManager.longitude)
								}
						} else {
							Text("Error Loading Location")
						}
					}
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.blue.opacity(0.75))
					.clipShape(RoundedRectangle(cornerRadius: 25))
				}
				// Allows user to click on the plant to navigate to its MyPlantDetailView
				.navigationDestination(for: MyPlant.self) { plant in
					MyPlantDetailView(myPlant: plant)
				}
			}
			// Load Data and if the data is not empty, update the times on the next plant to be watered
			.onAppear() {
				myPlants.loadData()
				if !myPlants.myPlants.isEmpty {
					getPlantToWater().updateTime()
					timeRemaining = getPlantToWater().calculatePlantTimer()
					myPlants.save()
				}
			}
		}
	}
	
	// Converts seconds to Time Format hour:minutes:seconds
	func convertSeconds(sec : Int) -> String {
		let seconds = (sec % 3600) % 60
		let minutes = (sec % 3600) / 60
		let hours = sec / 3600
		
		return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
	}
	
	// Gets the Next MyPlant to be watered
	func getPlantToWater() -> MyPlant {
		if !myPlants.myPlants.isEmpty {
			var shortestTime = myPlants.myPlants[0]
			for myPlant in myPlants.myPlants {
				if myPlant.calculatePlantTimer() < shortestTime.calculatePlantTimer() {
					shortestTime = myPlant
				}
			}
			return shortestTime
		}
		return MyPlant()
	}
}


