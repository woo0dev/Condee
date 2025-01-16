//
//  CustomImagesGridView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI

struct CustomImagesGridView: View {
	@ObservedObject var viewModel: MainSceneViewModel
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: viewModel.numberOfColumns), spacing: 20) {
				ForEach(viewModel.customImages.indices, id: \.self) { index in
					NavigationLink(value: viewModel.customImages[index], label: {
						if let image = viewModel.images[index] {
							Image(uiImage: image)
								.resizable()
								.accessibilityIdentifier("CustomImageView")
								.scaledToFit()
								.contextMenu {
									Button(action: {
										viewModel.deleteCustomImage(viewModel.customImages[index])
									}, label: {
										Label("삭제", systemImage: "trash")
									})
								}
								.onLongPressGesture {
									viewModel.didLongPressGesture()
								}
						}
					})
					.cornerRadius(20)
				}
			}
			.gesture(
				MagnificationGesture()
					.onChanged { value in
						viewModel.handlePinchGesture(with: value)
					}
			)
			.accessibilityIdentifier("CustomImagesView")
		}
		.refreshable {
			viewModel.fetchAll()
		}
	}
}
