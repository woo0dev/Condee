//
//  HeaderView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI

struct HeaderView: View {
	var title: String
	
	var body: some View {
		Text(title)
			.font(.largeTitle)
			.accessibilityIdentifier(title)
	}
}
