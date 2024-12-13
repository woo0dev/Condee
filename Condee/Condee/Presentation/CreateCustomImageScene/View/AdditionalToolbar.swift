//
//  AdditionalToolbar.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct AdditionalToolbar: View {
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var body: some View {
		HStack(spacing: 20) {
			Button(action: {
				viewModel.actionSheetType = .image
				viewModel.didSelectAddPhotoButton()
			}, label: {
				Image(systemName: "photo")
					.resizable()
					.scaledToFit()
					.frame(width: 40, height: 40)
			})
			.accessibilityIdentifier("AddPhotoButton")
			.foregroundStyle(colorScheme == .light ? .black : .white)
			Button(action: {
				viewModel.didSelectAddStickerButton()
			}, label: {
				Image(systemName: "e.circle")
					.resizable()
					.scaledToFit()
					.frame(width: 40, height: 40)
			})
			.accessibilityIdentifier("AddStickerButton")
			.foregroundStyle(colorScheme == .light ? .black : .white)
			Button(action: {
				viewModel.actionSheetType = .text
				viewModel.didSelectAddTextButton()
			}, label: {
				Image(systemName: "t.circle")
					.resizable()
					.scaledToFit()
					.frame(width: 40, height: 40)
			})
			.accessibilityIdentifier("AddTextButton")
			.foregroundStyle(colorScheme == .light ? .black : .white)
			Spacer()
		}
	}
}

#Preview {
	AdditionalToolbar(viewModel: DependencyContainer.shared.makeCreateCustomImageSceneViewModel())
}
