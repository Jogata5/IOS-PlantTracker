// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  ContentView.swift
//  Plant Tracker
//
//  Created by csuftitan on 11/15/22.
//

import SwiftUI
import WebKit
import WeatherKit

// Holds the TabViews
struct ContentView: View {
	@State private var selection = 3
	var body: some View {
		Group {
			TabView(selection: $selection) {
				WebView()
					.tabItem {
						Image(systemName: "magnifyingglass.circle")
						Text("Web Search")
					}
					.tag(1)
				PlantListView()
					.tabItem {
						Image(systemName: "text.book.closed.fill")
						Text("Encyclopedia")
					}
					.tag(2)
				HomePageView()
					.tabItem {
						Image(systemName: "house.fill")
						Text("Home")
					}
					.tag(3)
				MyPlantsView()
					.tabItem {
						Image(systemName: "tree")
						Text("My Plants")
					}
					.tag(4)
				SettingsView()
					.tabItem {
						Image(systemName: "gear")
						Text("Settings")
					}
					.tag(5)
			}
			.toolbar(.visible, for: .tabBar)
			.toolbarBackground(
				Color.white,
				for: .tabBar)
		}
	}
	
	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView()
				.environment(\.colorScheme, .light)
			
			ContentView()
				.environment(\.colorScheme, .dark)
		}
	}
}
