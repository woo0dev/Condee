//
//  AdditionalButtonsView.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct AdditionalButtonsView: View {
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var body: some View {
		HStack(spacing: 30) {
			Button(action: {
				viewModel.didSelectAddPhotoButton()
			}, label: {
				Image(systemName: "photo")
					.resizable()
					.scaledToFit()
					.frame(width: 40, height: 40)
			})
			.foregroundStyle(colorScheme == .light ? .black : .white)
			.accessibilityIdentifier("AddPhotoButton")
			Button(action: {
				viewModel.didSelectAddEmojiButton()
			}, label: {
				Image(systemName: "e.circle")
					.resizable()
					.scaledToFit()
					.frame(width: 40, height: 40)
			})
			.foregroundStyle(colorScheme == .light ? .black : .white)
			.accessibilityIdentifier("AddEmojiButton")
			Button(action: {
				viewModel.didSelectAddTextButton()
			}, label: {
				Image(systemName: "t.circle")
					.resizable()
					.scaledToFit()
					.frame(width: 40, height: 40)
			})
			.foregroundStyle(colorScheme == .light ? .black : .white)
			.accessibilityIdentifier("AddTextButton")
			Spacer()
		}
	}
}

#Preview {
	AdditionalButtonsView(viewModel: CreateCustomImageSceneViewModel())
}
