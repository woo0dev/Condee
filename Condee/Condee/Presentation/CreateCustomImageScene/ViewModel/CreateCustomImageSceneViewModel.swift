//
//  CreateCustomImageSceneViewModel.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import Combine
import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class CreateCustomImageSceneViewModel: ObservableObject {
	@Published var selectedPhotosItems: [PhotosPickerItem] = []
	@Published var imageSource: ImageSource? = nil
	
	@Published var selectedBackgroundImage: Image? = nil
	@Published var addedCanvasElements: [CanvasElement] = []
	@Published var currentEditingCanvasElement: CanvasElement? = nil
	
	@Published var isPhotosPickerPresented: Bool = false
	@Published var isPhotoActionSheetPresented: Bool = false
	@Published var isEmojiHalfModalPresented: Bool = false
	@Published var isTextActionSheetPresented: Bool = false
	@Published var isColorPickerPresented: Bool = false
	
	func didSelectAddPhotoButton() {
		isPhotoActionSheetPresented = true
	}
	
	func didSelectBackgroundImageOption() {
		imageSource = .backgroundImage
		isPhotosPickerPresented = true
	}
	
	func didSelectAddImageOption() {
		imageSource = .additionalImage
		isPhotosPickerPresented = true
	}
	
	func didSelectAddEmojiButton() {
		isEmojiHalfModalPresented = true
	}
	
	func didSelectEmoji(emojiImage: Image) {
		let canvasElement = CanvasElement(type: .emoji(emojiImage))
		addedCanvasElements.append(canvasElement)
		currentEditingCanvasElement = canvasElement
	}
	
	func didSelectAddTextButton() {
		isTextActionSheetPresented = true
	}
	
	func didSelectDeleteButton(index: Int) {
		addedCanvasElements.remove(at: index)
		currentEditingCanvasElement = nil
	}
	
	func convertPhotosPickerItemsToImage() {
		if let item = selectedPhotosItems.first {
			item.loadTransferable(type: Data.self) { loadingResult in
				switch loadingResult {
				case .success(let data):
					if let data = data,
					   let uiImage = UIImage(data: data) {
						Task { @MainActor in
							if let source = self.imageSource {
								switch source {
								case .backgroundImage:
									self.selectedBackgroundImage = Image(uiImage: uiImage)
								case .additionalImage:
									let canvasElement = CanvasElement(type: .additionalImage(Image(uiImage: uiImage)))
									self.addedCanvasElements.append(canvasElement)
									self.currentEditingCanvasElement = canvasElement
								case .extractImage:
									let canvasElement = CanvasElement(type: .extractImage(Image(uiImage: uiImage)))
									self.addedCanvasElements.append(canvasElement)
									self.currentEditingCanvasElement = canvasElement
								}
							}
							// TODO: source가 초기화 되지 않았을 경우 예외처리
						}
					}
				case .failure(let error):
					print("Failed to load photo: \(error)")
				}
			}
		}
	}
}
