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
		if let index = viewModel.addedCanvasElements.firstIndex(where: { $0.id == viewModel.currentEditingCanvasElement?.id }), let element = viewModel.addedCanvasElements[safe: index], element.type.isTextElement {
			HStack(spacing: 20) {
				HStack(spacing: 0) {
					Text("\(Int(viewModel.addedCanvasElements[index].fontSize))")
						.accessibilityIdentifier("FontSizeLabel")
						.frame(width: 30)
						.font(.system(size: 17))
						.foregroundStyle(.primary)
					Text("pt")
						.font(.system(size: 17))
						.foregroundStyle(.primary)
				}
				ResizeButton(size: $fontSize, minSize: 5, maxSize: 100)
				ColorPicker("", selection: $selectedColor)
					.labelsHidden()
					.accessibilityAddTraits(.isButton)
					.accessibilityIdentifier("ColorPickerButton")
					.frame(width: 30, height: 30)
			}
			.onAppear {
				fontSize = viewModel.currentEditingCanvasElement?.fontSize ?? 17
			}
			.onChange(of: fontSize, {
				viewModel.updateFontSize(newSize: fontSize, index: index)
			})
			.onChange(of: selectedColor, {
				viewModel.updateTextColor(newColor: selectedColor, index: index)
			})
		}
	}
}
