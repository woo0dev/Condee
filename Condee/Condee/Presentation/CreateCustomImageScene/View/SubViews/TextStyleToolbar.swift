//
//  TextStyleToolbar.swift
//  Condee
//
//  Created by woo0 on 11/26/24.
//

import SwiftUI

struct TextStyleToolbar: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@State private var colorPickerSize: CGSize = .zero
	
	@State var fontSize: CGFloat = 17
	@State var selectedColor: Color = .black
	
	var body: some View {
		HStack(spacing: 20) {
			if let index = viewModel.addedCanvasElements.firstIndex(where: { $0.id == viewModel.currentEditingCanvasElement?.id }) {
				if let element = viewModel.addedCanvasElements[safe: index] {
					if element.type.isTextElement {
						Text("\(Int(viewModel.addedCanvasElements[index].fontSize)) pt")
							.accessibilityIdentifier("FontSizeLabel")
							.font(.system(size: 20))
							.foregroundStyle(.primary)
						ResizeButton(size: $fontSize, minSize: 5, maxSize: 100)
						ColorPicker("", selection: $selectedColor)
							.labelsHidden()
							.scaleEffect(1.5)
							.background(GeometryReader { geometry in
								Color.clear.onAppear {
									colorPickerSize = CGSize(width: geometry.size.width * 1.5, height: geometry.size.height * 1.5)
								}
							})
							.accessibilityAddTraits(.isButton)
							.accessibilityIdentifier("ColorPickerButton")
							.frame(width: colorPickerSize == .zero ? 40 : colorPickerSize.width, height: colorPickerSize == .zero ? 40 : colorPickerSize.height)
					}
				}
			}
		}
		.onAppear {
			fontSize = viewModel.currentEditingCanvasElement?.fontSize ?? 17
		}
		.onChange(of: fontSize, {
			if let index = viewModel.addedCanvasElements.firstIndex(where: { $0.id == viewModel.currentEditingCanvasElement?.id }) {
				viewModel.updateFontSize(newSize: fontSize, index: index)
			}
		})
		.onChange(of: selectedColor, {
			if let index = viewModel.addedCanvasElements.firstIndex(where: { $0.id == viewModel.currentEditingCanvasElement?.id }) {
				viewModel.updateTextColor(newColor: selectedColor, index: index)
			}
		})
	}
}

//#Preview {
//	TextStyleToolbar(viewModel: DependencyContainer.shared.makeCreateCustomImageSceneViewModel(), fontSize: 17, selectedColor: .black)
//}
