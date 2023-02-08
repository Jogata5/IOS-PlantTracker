// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  Plant.swift
//  Plant Tracker
//
//  Created by csuftitan on 11/15/22.
//

import SwiftUI

// Struct of Plant, Data obtained from json file
struct Plant: Hashable, Codable {
	var id = UUID()
	let Latin_name : String!
	let Family : String?
	let Other_names : String?
	let Common_name : [String?]?
	let Common_name_fr : String?
	let img : String?
	let Description : String?
	let Categories : String?
	let Origin : [String]?
	let Climate : String?
	let Temperature_max: [String : Double]?
	let Temperature_min: [String : Double]?
	let Zone : [String]?
	let Growth : String?
	let Light_ideal : String?
	let Light_tolerated : String?
	let Watering : String?
	let Insects : [String]?
	let Disease : String?
	let Appeal : String?
	let Color_of_leaf : [String]?
	let Color_of_blooms : String?
	let Blooming_season : String?
	let Perfume : String?
	let Avaibility : String?
	let Pot_diameter : [String : Double]?
	let Height_at_purchase : [String : Double]?
	let Width_at_purchase: [String : Double]?
	let Height_potential: [String : Double]?
	let Width_potential: [String : Double]?
	let Available_sizes: String?
	let Bearing : String?
	let Clump: String?
	let Pruning : String?
	let Style : String?
	let Use : [String]?
	
	// Checks each type of name (except Latin) for the plant and returns the one that exists
	func checkNames() -> String {
		if !self.Latin_name.isEmpty {
			return self.Common_name_fr ?? self.Common_name?[0] ?? self.Other_names ?? " "
		}
		return ""
	}
}

// Allows Plant Images to display
struct URLImage: View {
	let urlString : String?

	@State var data : Data?

	var body: some View {
		// If the image data exist, show. Else, show placeholder
		if let data = data, let uiimage = UIImage(data:data) {
			Image(uiImage: uiimage)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 100, height: 70)
				.background(Color.gray)
				.clipShape(Circle())
		} else {
			Image(systemName: "video")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 100, height: 70)
				.background(Color.gray)
				.clipShape(Circle())
				.onAppear {
					fetchData()
				}
		}
	}
	// Fetches image data
	private func fetchData() {
		guard let url = URL(string: urlString ?? "") else { return }

		let task = URLSession.shared.dataTask(with: url) { data, _, _ in
			self.data = data
		}
		task.resume()
	}
}
