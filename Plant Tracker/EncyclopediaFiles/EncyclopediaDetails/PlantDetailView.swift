// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  PlantDetailView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/11/22.
//

import SwiftUI

// Struct of the Plant detail view controller
struct PlantDetailView : View {
	let plant: Plant
	
	@ObservedObject var settings = SettingsList()
	@State var isShowingAddView = false
	@State var isShowingWeb = false
	@State private var navPath = NavigationPath()
	
	
	
	var body: some View {
		ScrollView {
			VStack {
				URLImage(urlString: plant.img ?? "")
				Text(plant.checkNames())
				Spacer()
				// Displays General info of the plant
				Section("Info") {
					VStack {
						Text("Common Names:\n\(plant.Common_name_fr ?? "")\n \(plant.Common_name?[0] ?? "")\n \(plant.Other_names ?? "")")
						Text("Origin: \(plant.Origin?.joined(separator: ", ") ?? "N/A" )")
						Text("Family \(plant.Family ?? "N/A")")
						Text("Possible Diseases: \(plant.Disease ?? "N/A")")
						Text("Common Pests: \(plant.Insects?.joined(separator: ", ") ?? "N/A" )")
						Text("Blooming Season: \(plant.Blooming_season ?? "N/A")")
						
					}
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.gray.opacity(0.75))
					.clipShape(RoundedRectangle(cornerRadius: 25))
				}
				// Displays Care details
				Section("Care") {
					VStack {
						Text("Climate: \(plant.Climate ?? "N/A")")
						Text("Min Temperature: \(plant.Temperature_min?[settings.settings.translateTempKey()]?.rounded() ?? 0) \(settings.settings.translateTempKey())")
						Text("Max Temperature: \(plant.Temperature_max?[settings.settings.translateTempKey()]?.rounded() ?? 0) \(settings.settings.translateTempKey())")
						Text("Pot Diameter: \(plant.Pot_diameter?[settings.settings.translateMeasureKey()] ?? 0) \(settings.settings.translateMeasureKey())")
						Text("Growth: \(plant.Growth ?? "N/A")")
						Text("Ideal Light: \(plant.Light_ideal ?? "N/A")")
						Text("Watering Habit: \(plant.Watering ?? "N/A")")
					}
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.gray.opacity(0.75))
					.clipShape(RoundedRectangle(cornerRadius: 25))
				}
				// Misc Info
				Section("Misc") {
					VStack {
						Text("Blooming Season: \(plant.Blooming_season ?? "N/A")")
						Text("Categories: \(plant.Categories ?? "N/A")")
						Text("Description: \(plant.Description ?? "N/A")")
					}
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.gray.opacity(0.75))
					.clipShape(RoundedRectangle(cornerRadius: 25))
				}
				// Button to pull up a sheet containing a web search of the plant
				Button("Check Web") {
					isShowingWeb = true
				}
				.padding(3)
				.clipShape(Capsule())
				.sheet(isPresented: $isShowingWeb) {
					Web(url: URL(string: "http://www.google.com/search?q=\(plant.Latin_name!.replacingOccurrences(of: " ", with: "+"))")!)
				}
			}
			.toolbar {
				// Shows sheet view to add a new plant to MyPlants
				Button("Add MyPlants") {
					isShowingAddView = true
				}
				.sheet(isPresented: $isShowingAddView) {
					AddPlantView(plant: plant)
				}
			}
		}
	}
}
