//
//  CustomImagesGridView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI

struct CustomImagesGridView: View {
	@ObservedObject var viewModel: MainSceneViewModel
	
	@Binding var navigationPath: NavigationPath
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: viewModel.numberOfColumns), spacing: 2) {
				ForEach(viewModel.customImages.indices, id: \.self) { index in
					if let image = viewModel.images[index] {
						Button(action: {
							guard !viewModel.isNavigationActive, !viewModel.isPinchActive else { return }
							viewModel.startNavigation()
							navigationPath.append(index)
						}, label: {
							Image(uiImage: image)
								.resizable()
								.scaledToFit()
								.contextMenu {
									Button(action: {
										viewModel.deleteCustomImage(viewModel.customImages[index])
									}, label: {
										Label("삭제", systemImage: "trash")
									})
									.accessibilityIdentifier("DeleteButton")
								}
						})
						.accessibilityIdentifier("CustomImageView")
					}
				}
			}
			.accessibilityIdentifier("CustomImagesGridView")
			.animation(.easeInOut, value: viewModel.numberOfColumns)
		}
		.highPriorityGesture(
			MagnificationGesture()
				.onChanged { value in
					if !viewModel.isPinchActive {
						viewModel.startPinchGesture()
					}
					let delta = value - viewModel.lastPinchThreshold
					if delta <= -0.2 {
						viewModel.handlePinchGesture(increase: true, value: value)
					} else if delta >= 0.2 {
						viewModel.handlePinchGesture(increase: false, value: value)
					}
				}
				.onEnded { _ in
					viewModel.endPinchGesture()
				}
		)
	}
}
