//
//  RoundedRectangleButtonStyle.swift
//  Condee
//
//  Created by woo0 on 1/2/25.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.title3)
			.padding()
			.foregroundColor(Color(.systemBackground))
			.background(.primary)
			.cornerRadius(20)
			.scaleEffect(configuration.isPressed ? 0.95 : 1.0)
	}
}
