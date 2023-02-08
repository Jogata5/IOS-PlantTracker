// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  PlantDictView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/11/22.
//

import SwiftUI

// The Plant List View
struct PlantListView: View {
	@ObservedObject var plantList = PlantList()
	@State private var searchText = ""
	@State private var navPath = NavigationPath()
	
	var body: some View {
		NavigationStack(path: $navPath) {
			List {
				// Displays all plants in relation to the search. If search is empty, show all plants
				ForEach(searchResults, id: \.self) { plant in
					NavigationLink(value: plant) {
						HStack {
							URLImage(urlString: plant.img ?? "N/A")
							VStack {
								Text(plant.Latin_name)
									.font(
										.system(size: 18, weight: .bold, design: .rounded)
									)
									.multilineTextAlignment(.leading)
								Text(plant.checkNames() )
									.font(
										.system(size: 16)
									)
									.multilineTextAlignment(.leading)
							}
						}
						Spacer()
					}
					.padding(3)
				}
				.id(UUID())
			}
			// Allows each Plant to navigate to its respective detail view
			.navigationTitle("Plants")
			.navigationDestination(for: Plant.self) { plant in
				PlantDetailView(plant: plant)
			}
			.searchable(text: $searchText, prompt: "Search")
		}
	}

	// Allows the plant list to be filtered according to the user's search
	var searchResults: [Plant] {
		if searchText.isEmpty {
			return plantList.plants
		} else {
			return plantList.plants.filter { $0.Latin_name.contains(searchText) }
		}
	}
	
	
}
