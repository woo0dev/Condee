//
//  ImageGestureModifier.swift
//  Condee
//
//  Created by woo0 on 11/9/24.
//

import SwiftUI

struct ImageGestureModifier: ViewModifier {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@Binding var canvasElement: CanvasElement
	
	@State private var initialDragTranslation: CGSize = .zero
	
	var index: Int
	
	func body(content: Content) -> some View {
		GeometryReader { geometry in
			ZStack {
				content
					.background(
						GeometryReader { contentGeometry in
							Color.clear
								.onAppear {
									if canvasElement.size == .zero {
										canvasElement.size = CGSize(width: contentGeometry.size.width / 2, height: contentGeometry.size.height / 2)
										canvasElement.offset = CGSize(
											width: geometry.size.width / 2 - canvasElement.size.width / 2,
											height: geometry.size.height / 2 - canvasElement.size.height / 2
										)
									}
								}
								.onChange(of: contentGeometry.size) { _, newSize in
									canvasElement.size = newSize
								}
						}
					)
					.frame(width: canvasElement.size.width == .zero ? geometry.size.width : canvasElement.size.width, height:  canvasElement.size.height == .zero ? geometry.size.height : canvasElement.size.height)
					.rotationEffect(canvasElement.rotation, anchor: .center)
					.overlay(
						Color.clear
							.border(.blue, width: viewModel.currentEditingCanvasElement == canvasElement ? 2 : 0)
							.frame(width: canvasElement.size.width, height: canvasElement.size.height)
							.rotationEffect(viewModel.addedCanvasElements[safe: index]?.rotation ?? .zero, anchor: .center)
					)
					.onTapGesture {
						if viewModel.currentEditingCanvasElement == canvasElement {
							viewModel.currentEditingCanvasElement = nil
						} else {
							viewModel.currentEditingCanvasElement = canvasElement
						}
					}
					.gesture(
						viewModel.currentEditingCanvasElement == canvasElement
						? DragGesture()
							.onChanged { value in
								canvasElement.offset.width += value.translation.width
								canvasElement.offset.height += value.translation.height
							}
						: nil
					)
				if viewModel.currentEditingCanvasElement == canvasElement {
					Button(action: {
						viewModel.didSelectDeleteButton(index: index)
					}, label: {
						Image(systemName: "xmark.circle.fill")
							.resizable()
							.foregroundStyle(.white, .red)
							.frame(width: 20, height: 20)
					})
					.accessibilityIdentifier("ElementDeleteButton")
					.offset(x: -canvasElement.size.width / 2, y: -canvasElement.size.height / 2)
					.rotationEffect(canvasElement.rotation, anchor: .center)
					Image(systemName: "arrow.up.left.and.arrow.down.right.circle.fill")
						.resizable()
						.accessibilityIdentifier("AdjustButton")
						.foregroundStyle(.white, .blue)
						.frame(width: 20, height: 20)
						.offset(x: canvasElement.size.width / 2, y: canvasElement.size.height / 2)
						.rotationEffect(canvasElement.rotation, anchor: .center)
						.gesture(
							DragGesture()
								.onChanged { value in
									let aspectRatio = canvasElement.size.width / canvasElement.size.height
									
									let dx = value.location.x
									let dy = value.location.y
									
									let maxDimension = max(abs(dx), abs(dy)) * 2

									let newWidth = maxDimension
									let newHeight = newWidth / aspectRatio
									
									let centerOffset = CGPoint(x: canvasElement.offset.width + canvasElement.size.width / 2, y: canvasElement.offset.height + canvasElement.size.height / 2)

									canvasElement.size = CGSize(width: newWidth, height: newHeight)
									
									canvasElement.offset.width = centerOffset.x - newWidth / 2
									canvasElement.offset.height = centerOffset.y - newHeight / 2
									
									let centerX = canvasElement.offset.width + canvasElement.size.width / 2
									let centerY = canvasElement.offset.height + canvasElement.size.height / 2

									let buttonX = canvasElement.offset.width + canvasElement.size.width
									let buttonY = canvasElement.offset.height + canvasElement.size.height
									
									let newAngle = Angle(radians: atan2(dy, dx) - atan2(buttonY - centerY, buttonX - centerX))
									let remainder = abs(newAngle.degrees.truncatingRemainder(dividingBy: 90))
									if remainder < 5 || remainder > 85 {
										canvasElement.rotation.degrees = round(newAngle.degrees / 90) * 90
									} else {
										canvasElement.rotation = newAngle
									}
								}
						)
				}
			}
			.offset(
				canvasElement.offset == .zero
				? CGSize(
					width: geometry.size.width / 2 - canvasElement.size.width / 2,
					height: geometry.size.height / 2 - canvasElement.size.height / 2
				)
				: canvasElement.offset
			)
		}
	}
}
