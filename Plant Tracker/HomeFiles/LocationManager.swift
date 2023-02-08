// 	Julian Ogata
// 	12/16/2022
// 	jogata@csu.fullerton.edu
//
//  LocationManager.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/16/22.
//


import Foundation
import CoreLocation

// Holds the Location Manager
class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
	var locationManager = CLLocationManager()
	
	@Published var authorizationStatus: CLAuthorizationStatus?
	
	var latitude: Double {
		locationManager.location?.coordinate.latitude ?? 0.0
	}
	
	var longitude: Double {
		locationManager.location?.coordinate.longitude ?? 0.0
	}
	
	override init() {
		super.init()
		locationManager.delegate = self
	}
	
	// Checks to User's authorization to allow app to track location
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		switch manager.authorizationStatus {
		case .authorizedWhenInUse:  // Location services are available.
			authorizationStatus = .authorizedWhenInUse
			locationManager.requestLocation()
			break
			
		case .restricted:  // Location services currently unavailable.
			authorizationStatus = .restricted
			break
			
		case .denied:  // Location services currently unavailable.
			authorizationStatus = .denied
			break
			
		case .notDetermined:        // Authorization not determined yet.
			authorizationStatus = .notDetermined
			manager.requestWhenInUseAuthorization()
			break
			
		default:
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print("User has Updated Location")
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("error: \(error.localizedDescription)")
	}
	
	
}
