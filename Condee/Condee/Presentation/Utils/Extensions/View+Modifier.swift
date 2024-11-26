//
//  View+Modifier.swift
//  Condee
//
//  Created by woo0 on 11/9/24.
//

import SwiftUI

extension View {
	func handleImageGesture(viewModel: CreateCustomImageSceneViewModel, canvasElement: Binding<CanvasElement>, index: Int) -> some View {
		self.modifier(ImageGestureModifier(viewModel: viewModel, canvasElement: canvasElement, index: index))
	}
	
	func handleTextField(viewModel: CreateCustomImageSceneViewModel, canvasElement: Binding<CanvasElement>, index: Int) -> some View {
		self.modifier(InteractiveTextFieldModifier(viewModel: viewModel, canvasElement: canvasElement, index: index))
	}
}
