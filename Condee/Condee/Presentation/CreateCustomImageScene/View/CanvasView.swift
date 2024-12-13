//
//  CanvasView.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct CanvasView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@State private var isImageVisible: Bool = true
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				GridPatternBackgroundView()
					.accessibilityIdentifier("GridPatternBackgroundView")
					.onTapGesture {
						viewModel.currentEditingCanvasElement = nil
					}
				if isImageVisible, let backgroundImage = viewModel.selectedBackgroundImage {
					backgroundImage
						.resizable()
						.accessibilityIdentifier("GridPatternBackgroundWithImage")
						.scaledToFit()
						.onTapGesture {
							viewModel.currentEditingCanvasElement = nil
						}
						.handleBackgroundImageGesture(canvasSize: geometry.size)
				}
				ForEach(viewModel.addedCanvasElements.indices, id: \.self) { index in
					switch viewModel.addedCanvasElements[index].type {
					case .additionalImage(let image), .sticker(let image), .extractImage(let image):
						image
							.resizable()
							.accessibilityIdentifier("AddedImageView")
							.scaledToFit()
							.handleImageGesture(viewModel: viewModel, canvasElement: $viewModel.addedCanvasElements[index], index: index)
							.clipShape(Rectangle()
								.size(width: geometry.size.width, height: geometry.size.height)
							)
					case .directInputText(let content):
						Text(content)
							.handleTextField(viewModel: viewModel, canvasElement: $viewModel.addedCanvasElements[index], index: index)
							.clipShape(Rectangle()
								.size(width: geometry.size.width, height: geometry.size.height)
							)
					}
				}
			}
			.onChange(of: viewModel.selectedBackgroundImage, {
				isImageVisible = false
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					isImageVisible = true
				}
			})
		}
	}
}
