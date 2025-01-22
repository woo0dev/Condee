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
		.navigationBarItems(
			trailing:
				HStack {
					ShareLink(
						item: previewImage,
						preview: SharePreview(previewImage.caption, image: previewImage.image)
					)
					.padding()
					Button(action: {
						viewModel.saveCreatedImage()
					}, label: {
						Text("저장")
					})
				}
		)
		.onChange(of: viewModel.isSavingComplete, {
			if viewModel.isSavingComplete {
				navigationPath = .init()
			}
		})
	}
}
