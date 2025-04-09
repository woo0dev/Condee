//
//  View+Modifier.swift
//  Condee
//
//  Created by woo0 on 11/9/24.
//

import SwiftUI

extension View {
	func handleBackgroundImageGesture(backgroundImageRect: Binding<CGRect>, cropRect: Binding<CGRect>, canvasSize: CGSize) -> some View {
		self.modifier(BackgroundImageGestureModifier(backgroundImageRect: backgroundImageRect, cropRect: cropRect, canvasSize: canvasSize))
	}
	
	func handleImageGesture(viewModel: CreateCustomImageSceneViewModel, canvasElement: Binding<CanvasElement>, index: Int) -> some View {
		self.modifier(ImageGestureModifier(viewModel: viewModel, canvasElement: canvasElement, index: index))
	}
	
	func handleTextField(viewModel: CreateCustomImageSceneViewModel, canvasElement: Binding<CanvasElement>, index: Int) -> some View {
		self.modifier(InteractiveTextFieldModifier(viewModel: viewModel, canvasElement: canvasElement, index: index))
	}
	
	func toast(isPresented: Binding<Bool>, message: String) -> some View {
		self.modifier(ToastModifier(isPresented: isPresented, message: message))
	}
}

extension View {
	@ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
		if condition {
			transform(self)
		} else {
			self
		}
	}
}
