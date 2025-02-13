//
//  AdditionalToolbar.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct AdditionalToolbar: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var body: some View {
		HStack(spacing: 20) {
			Button(action: {
				viewModel.actionSheetType = .image
				viewModel.didSelectAddPhotoButton()
			}, label: {
				Image(systemName: "photo.on.rectangle.angled")
					.resizable()
					.scaledToFit()
					.frame(width: 30, height: 30)
			})
			.accessibilityIdentifier("AddPhotoButton")
			.buttonStyle(.plain)
			Button(action: {
				viewModel.didSelectAddStickerButton()
			}, label: {
				Image(systemName: "face.smiling")
					.resizable()
					.scaledToFit()
					.frame(width: 30, height: 30)
			})
			.accessibilityIdentifier("AddStickerButton")
			.buttonStyle(.plain)
			Button(action: {
				viewModel.actionSheetType = .text
				viewModel.didSelectAddTextButton()
			}, label: {
				Image(systemName: "square.and.pencil")
					.resizable()
					.scaledToFit()
					.frame(width: 30, height: 30)
			})
			.accessibilityIdentifier("AddTextButton")
			.buttonStyle(.plain)
		}
	}
}

//#Preview {
//	AdditionalToolbar(viewModel: DependencyContainer.shared.makeCreateCustomImageSceneViewModel())
//}
