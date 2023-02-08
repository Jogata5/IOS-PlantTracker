//
//  WebView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/16/22.
//

import SwiftUI

struct WebView : View {
	@State private var showWebView = false
	
	var body: some View {
		Web(url: URL(string: "https://www.google.com")!)
	}
}
