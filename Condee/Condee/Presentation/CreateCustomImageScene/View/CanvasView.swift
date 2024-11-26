//
//  CanvasView.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct CanvasView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				GridPatternBackgroundView()
					.accessibilityIdentifier("GridPatternBackgroundView")
					.onTapGesture {
						viewModel.currentEditingCanvasElement = nil
					}
				if let backgroundImage = viewModel.selectedBackgroundImage {
					backgroundImage
						.resizable()
						.accessibilityIdentifier("GridPatternBackgroundWithImage")
						.onTapGesture {
							viewModel.currentEditingCanvasElement = nil
						}
				}
				ForEach(viewModel.addedCanvasElements.indices, id: \.self) { index in
					switch viewModel.addedCanvasElements[index].type {
					case .additionalImage(let image), .emoji(let image), .extractImage(let image):
						image
							.resizable()
							.scaledToFit()
							.handleImageGesture(viewModel: viewModel, canvasElement: $viewModel.addedCanvasElements[index], index: index)
							.clipShape(Rectangle()
								.size(width: geometry.size.width, height: geometry.size.height)
							)
					case .directInputText(let content):
						Text(content)
							.handleTextField(viewModel: viewModel, canvasElement: $viewModel.addedCanvasElements[index], index: index)
					}
				}
			}
		}
	}
}
