//
//  CapturedCanvasView.swift
//  Condee
//
//  Created by woo0 on 1/11/25.
//

import SwiftUI

struct CapturedCanvasView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var body: some View {
		ZStack(alignment: .topLeading) {
			if let backgroundImage = viewModel.finalCroppedBackgroundImage {
				Image(uiImage: backgroundImage)
					.resizable()
					.scaledToFit()
			}
			ForEach(viewModel.addedCanvasElements.indices, id: \.self) { index in
				let element = viewModel.addedCanvasElements[index]
				switch element.type {
				case .additionalImage(let image), .sticker(let image), .extractImage(let image):
					ZStack {
						image
							.resizable()
							.scaledToFit()
							.frame(width: element.size.width, height: element.size.height)
							.rotationEffect(element.rotation, anchor: .center)
						
					}
					.offset(x: element.offset.width, y: element.offset.height)
				case .directInputText(let content):
					ZStack {
						Text(content)
							.frame(width: element.size.width, height: element.size.height)
							.rotationEffect(element.rotation)
					}
					.offset(x: element.offset.width, y: element.offset.height)
				}
			}
		}
	}
}
