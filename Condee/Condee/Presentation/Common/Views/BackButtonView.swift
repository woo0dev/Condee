//
//  BackButtonView.swift
//  Condee
//
//  Created by woo0 on 4/6/25.
//

import SwiftUI

struct BackButtonView: View {
	var title: String = "뒤로"
	var iconName: String = "chevron.left"
	var action: (() -> Void)?

	var body: some View {
		Button {
			action?()
		} label: {
			HStack(spacing: 4) {
				Image(systemName: iconName)
				Text(title)
			}
		}
		.accessibilityIdentifier("BackButton")
		.buttonStyle(.plain)
	}
}
