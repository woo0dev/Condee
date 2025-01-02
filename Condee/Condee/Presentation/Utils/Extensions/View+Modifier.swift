//
//  View+Modifier.swift
//  Condee
//
//  Created by woo0 on 11/9/24.
//

import SwiftUI

extension View {
	func handleBackgroundImageGesture(canvasSize: CGSize) -> some View {
		self.modifier(BackgroundImageGestureModifier(canvasSize: canvasSize))
	}
	
	func handleImageGesture(viewModel: CreateCustomImageSceneViewModel, canvasElement: Binding<CanvasElement>, index: Int) -> some View {
		self.modifier(ImageGestureModifier(viewModel: viewModel, canvasElement: canvasElement, index: index))
	}
	
	func handleTextField(viewModel: CreateCustomImageSceneViewModel, canvasElement: Binding<CanvasElement>, index: Int) -> some View {
		self.modifier(InteractiveTextFieldModifier(viewModel: viewModel, canvasElement: canvasElement, index: index))
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
	
	func asUIImage() -> UIImage? {
		let controller = UIHostingController(rootView: self)
		let targetView = controller.view
		
		let targetSize = controller.sizeThatFits(in: CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
		targetView?.bounds = CGRect(origin: .zero, size: targetSize)
		targetView?.backgroundColor = .clear
		
		let renderer = UIGraphicsImageRenderer(size: targetSize)
		return renderer.image { context in
			targetView?.drawHierarchy(in: targetView!.bounds, afterScreenUpdates: true)
		}
	}
}
