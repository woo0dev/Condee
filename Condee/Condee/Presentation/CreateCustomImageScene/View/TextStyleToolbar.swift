//
//  TextStyleToolbar.swift
//  Condee
//
//  Created by woo0 on 11/26/24.
//

import SwiftUI

struct TextStyleToolbar: View {
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@State private var colorPickerSize: CGSize = .zero
	
	@State var fontSize: CGFloat = 17
	@State var selectedColor: Color = .black
	
	var body: some View {
		HStack(spacing: 20) {
			if let index = viewModel.addedCanvasElements.firstIndex(where: { $0.id == viewModel.currentEditingCanvasElement?.id }) {
				Text("\(Int(viewModel.addedCanvasElements[index].fontSize)) pt")
					.font(.system(size: 20))
					.foregroundStyle(colorScheme == .light ? .black : .white)
					.accessibilityIdentifier("FontSizeLabel")
				
				HStack(spacing: 0) {
					Button(action: {
						if fontSize - 1 >= 5 {
							fontSize -= 1
						}
					}, label: {
						Image(systemName: "minus")
							.font(.system(size: 24))
							.frame(maxWidth: .infinity, maxHeight: .infinity)
					})
					.frame(width: 40, height: 40)
					.foregroundStyle(colorScheme == .light ? .black : .white)
					.accessibilityIdentifier("IncreaseFontSizeButton")
					Divider()
						.frame(width: 1, height: 30)
						.foregroundStyle(colorScheme == .light ? .black : .white)
					Button(action: {
						if fontSize + 1 <= 100 {
							fontSize += 1
						}
					}, label: {
						Image(systemName: "plus")
							.font(.system(size: 24))
							.frame(maxWidth: .infinity, maxHeight: .infinity)
					})
					.frame(width: 40, height: 40)
					.foregroundStyle(colorScheme == .light ? .black : .white)
					.accessibilityIdentifier("DecreaseFontSizeButton")
				}
				.frame(height: 40)
				.background(Color.gray)
				.clipShape(RoundedRectangle(cornerRadius: 10))
				
				ColorPicker("", selection: $selectedColor)
					.labelsHidden()
					.scaleEffect(1.5)
					.background(GeometryReader { geometry in
						Color.clear.onAppear {
							colorPickerSize = CGSize(width: geometry.size.width * 1.5, height: geometry.size.height * 1.5)
						}
					})
					.frame(width: colorPickerSize == .zero ? 40 : colorPickerSize.width, height: colorPickerSize == .zero ? 40 : colorPickerSize.height)
					.accessibilityIdentifier("ColorPickerButton")
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

#Preview {
	@Previewable @Environment(\.colorScheme) var colorScheme
	TextStyleToolbar(colorScheme: _colorScheme, viewModel: DependencyContainer.shared.makeCreateCustomImageSceneViewModel(), fontSize: 17, selectedColor: .black)
}
