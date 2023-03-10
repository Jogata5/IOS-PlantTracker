//
//  WebView.swift
//  Plant Tracker
//
//  Created by csuftitan on 12/16/22.
//

import SwiftUI
import WebKit
 
struct Web: UIViewRepresentable {
 
	var url: URL
 
	func makeUIView(context: Context) -> WKWebView {
		return WKWebView()
	}
 
	func updateUIView(_ webView: WKWebView, context: Context) {
		let request = URLRequest(url: url)
		webView.load(request)
	}
}
