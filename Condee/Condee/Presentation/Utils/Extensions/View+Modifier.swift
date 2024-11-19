//
//  View+Modifier.swift
//  Condee
//
//  Created by woo0 on 11/9/24.
//

import SwiftUI

extension View {
	func handleCanvasElementGesture(viewModel: CreateCustomImageSceneViewModel, canvasElement: Binding<CanvasElement>, index: Int) -> some View {
		self.modifier(CanvasElementGestureModifier(viewModel: viewModel, canvasElement: canvasElement, index: index))
	}
}
