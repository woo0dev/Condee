//
//  CreateImageResultView.swift
//  Condee
//
//  Created by woo0 on 1/13/25.
//

import SwiftUI

struct CreateImageResultView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@Binding var navigationPath: NavigationPath
	
	let previewImage: PreviewImage
	
	var body: some View {
		VStack {
			previewImage.image
				.resizable()
				.scaledToFit()
				.padding(20)
		}
		.toolbar {
			ToolbarItem {
				HStack {
					ShareLink(
						item: previewImage,
						preview: SharePreview(previewImage.caption, image: previewImage.image)
					) {
						Image(systemName: "square.and.arrow.up")
					}
					.buttonStyle(.plain)
					.padding(.horizontal, 10)
					Button(action: {
						viewModel.completeCustomImageCreation()
					}, label: {
						Text("완료")
					})
					.buttonStyle(.plain)
					.padding(.horizontal, 10)
				}
				.frame(maxWidth: .infinity)
			}
		}
		.onChange(of: viewModel.isSavingComplete, {
			if viewModel.isSavingComplete {
				navigationPath = .init()
			}
		})
	}
}
