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
		ScrollView(.vertical) {
			LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: viewModel.numberOfColumns), spacing: 20) {
				ForEach(viewModel.customImages, id: \.self) { customImage in
					AsyncImage(url: customImage.imageURL) { phase in
						switch phase {
						case .empty:
							ProgressView()
						case .success(let image):
							NavigationLink(value: customImage, label: {
								image
									.resizable()
									.accessibilityIdentifier("CustomImageView")
									.scaledToFit()
									.contextMenu {
										Button(action: {
											viewModel.deleteCustomImage(customImage)
										}, label: {
											Label("삭제", systemImage: "trash")
										})
									}
									.onLongPressGesture {
										viewModel.didLongPressGesture()
									}
							})
						case .failure:
							Image(systemName: "exclamationmark.triangle")
								.resizable()
								.scaledToFit()
						@unknown default:
							EmptyView()
						}
					}
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
	}
}
