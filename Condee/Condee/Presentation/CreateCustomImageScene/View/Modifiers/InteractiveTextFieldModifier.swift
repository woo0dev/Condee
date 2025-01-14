//
//  InteractiveTextFieldModifier.swift
//  Condee
//
//  Created by woo0 on 11/20/24.
//

import SwiftUI
import Combine

struct InteractiveTextFieldModifier: ViewModifier {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@Binding var canvasElement: CanvasElement
	
	@State private var isEditing: Bool = true
	@State private var isResized: Bool = false
	@State private var text: String = ""
	
	@FocusState private var isFocused: Bool
	
	private var editingHighlight: some View {
		Color.clear
			.border(.blue, width: viewModel.currentEditingCanvasElement == canvasElement ? 2 : 0)
			.frame(width: canvasElement.size.width, height: canvasElement.size.height)
			.rotationEffect(canvasElement.rotation, anchor: .center)
	}
	private var dragGesture: some Gesture {
		DragGesture()
			.onChanged { value in
				canvasElement.offset.width += value.translation.width
				canvasElement.offset.height += value.translation.height
			}
	}
	
	var index: Int
	
	func body(content: Content) -> some View {
		GeometryReader { geometry in
			ZStack {
				if isEditing {
					commonStyle(TextEditor(text: $text).accessibilityIdentifier("TextInputView"))
						.focused($isFocused)
						.scrollContentBackground(.hidden)
						.onAppear {
							isFocused = true
						}
					Color.clear
						.contentShape(Rectangle())
						.frame(width: canvasElement.size.width, height: canvasElement.size.height)
						.rotationEffect(canvasElement.rotation, anchor: .center)
						.overlay(editingHighlight)
						.onTapGesture() {
							viewModel.currentEditingCanvasElement = nil
						}
						.gesture(dragGesture)
				} else {
					commonStyle(content)
						.overlay(editingHighlight)
						.onTapGesture() {
							if viewModel.currentEditingCanvasElement == canvasElement {
								if isEditing {
									viewModel.currentEditingCanvasElement = nil
								} else {
									isEditing = true
								}
							} else {
								viewModel.currentEditingCanvasElement = canvasElement
							}
						}
						.gesture(viewModel.currentEditingCanvasElement == canvasElement ? dragGesture : nil)
				}
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
					Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
						.resizable()
						.accessibilityIdentifier("SizeAdjustButton")
						.foregroundStyle(.white, .blue)
						.frame(width: 20, height: 20)
						.offset(x: canvasElement.size.width / 2, y: -canvasElement.size.height / 2)
						.rotationEffect(canvasElement.rotation, anchor: .center)
						.gesture(
							DragGesture()
								.onChanged { value in
									let dx = value.location.x
									let dy = value.location.y
									
									let centerX = canvasElement.offset.width + canvasElement.size.width / 2
									let centerY = canvasElement.offset.height + canvasElement.size.height / 2

									let buttonX = canvasElement.offset.width + canvasElement.size.width
									let buttonY = canvasElement.offset.height
									
									canvasElement.rotation = Angle(radians: atan2(dy, dx) - atan2(buttonY - centerY, buttonX - centerX))
								}
						)
					Image(systemName: "arrow.up.left.and.arrow.down.right.circle.fill")
						.resizable()
						.accessibilityIdentifier("RotationAdjustButton")
						.foregroundStyle(.white, .blue)
						.frame(width: 20, height: 20)
						.offset(x: canvasElement.size.width / 2, y: canvasElement.size.height / 2)
						.rotationEffect(canvasElement.rotation, anchor: .center)
						.gesture(
							DragGesture()
								.onChanged { value in
									if isResized == false { isResized = true }
									
									let transform = CGAffineTransform(rotationAngle: canvasElement.rotation.radians)
									let rotatedLocation = value.location.applying(transform.inverted())
									
									let dx = rotatedLocation.x
									
									if dx > 5 {
										let newWidth = max(canvasElement.fontSize, abs(dx) * 2)
										canvasElement.size = textSizeFor(text: text, maxWidth: newWidth)
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
			.onChange(of: text, { _, newText in
				canvasElement.size = textSizeFor(text: text, maxWidth: canvasElement.size.width)
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
					if newText == text {
						viewModel.updateText(newText: text, index: index)
					}
				}
			})
			.onChange(of: canvasElement.fontSize, {
				canvasElement.size = textSizeFor(text: text, maxWidth: canvasElement.size.width)
			})
			.onChange(of: viewModel.currentEditingCanvasElement, {
				if isEditing {
					isEditing = false
				}
			})
		}
		.onAppear {
			if canvasElement.size == .zero {
				canvasElement.size = textSizeFor(text: text, maxWidth: canvasElement.size.width)
			}
		}
	}
	
	func commonStyle<V: View>(_ view: V) -> some View {
		view
			.font(.system(size: canvasElement.fontSize))
			.frame(width: canvasElement.size.width, height: canvasElement.size.height)
			.rotationEffect(canvasElement.rotation, anchor: .center)
			.foregroundStyle(canvasElement.fontColor)
	}
	
	func textSizeFor(text: String, maxWidth: CGFloat) -> CGSize {
		let uiFont = UIFont.systemFont(ofSize: canvasElement.fontSize)
		let attributes: [NSAttributedString.Key: Any] = [.font: uiFont]
		let width = (text as NSString).size(withAttributes: attributes).width + 20
		let constraintSize = isResized ? CGSize(width: maxWidth, height: .greatestFiniteMagnitude) : CGSize(width: width, height: .greatestFiniteMagnitude)
		
		let boundingBox = (text as NSString).boundingRect(
			with: constraintSize,
			options: .usesLineFragmentOrigin,
			attributes: attributes,
			context: nil
		)
		
		let newWidth = isResized ? maxWidth : ceil(boundingBox.width) + 20
		let newHeight = ceil(boundingBox.height) + 20
		
		return CGSize(width: newWidth, height: newHeight)
	}
}
