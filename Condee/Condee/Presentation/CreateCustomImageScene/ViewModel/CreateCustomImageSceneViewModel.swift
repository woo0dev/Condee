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
	@Published var actionSheetType: ActionSheetType? = nil
	
	@Published var selectedBackgroundImage: Image? = nil
	@Published var addedCanvasElements: [CanvasElement] = []
	@Published var currentEditingCanvasElement: CanvasElement? = nil
	@Published var extractUIImage: UIImage? = nil
	
	@Published var isPhotosPickerPresented: Bool = false
	@Published var isActionSheetPresented: Bool = false
	@Published var isStickerHalfModalPresented: Bool = false
	@Published var isExtractImageModalPresented: Bool = false
	@Published var isDirectInputModalPresented: Bool = false
	@Published var isColorPickerPresented: Bool = false
	
	private let updateTextUseCase: UpdateCanvasElementTextUseCase
	
	init(updateTextUseCase: UpdateCanvasElementTextUseCase) {
		self.updateTextUseCase = updateTextUseCase
	}
	
	func didSelectAddPhotoButton() {
		isActionSheetPresented = true
	}
	
	func didSelectBackgroundImageOption() {
		imageSource = .backgroundImage
		isPhotosPickerPresented = true
	}
	
	func didSelectAddImageOption() {
		imageSource = .additionalImage
		isPhotosPickerPresented = true
	}
	
	func didSelectAddStickerButton() {
		isStickerHalfModalPresented = true
	}
	
	func didSelectSticker(stickerImage: Image) {
		let canvasElement = CanvasElement(type: .sticker(stickerImage))
		addedCanvasElements.append(canvasElement)
		currentEditingCanvasElement = canvasElement
		isStickerHalfModalPresented = false
	}
	
	func didSelectAddTextButton() {
		isActionSheetPresented = true
	}
	
	func didSelectExtractImageOption() {
		imageSource = .extractImage
		isPhotosPickerPresented = true
	}
	
	func didSelectDirectInputOption() {
		let canvasElement = CanvasElement(type: .directInputText(""))
		addedCanvasElements.append(canvasElement)
		currentEditingCanvasElement = canvasElement
	}
	
	func didSelectDeleteButton(index: Int) {
		addedCanvasElements.remove(at: index)
		currentEditingCanvasElement = nil
	}
	
	func updateText(newText: String, index: Int) {
		addedCanvasElements[index] = updateTextUseCase.execute(element: addedCanvasElements[index], newText: newText)
	}
	
	func updateFontSize(newSize: CGFloat, index: Int) {
		addedCanvasElements[index].fontSize = newSize
	}
	
	func updateTextColor(newColor: Color, index: Int) {
		addedCanvasElements[index].fontColor = newColor
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
									self.isExtractImageModalPresented = true
									self.extractUIImage = uiImage
//									let canvasElement = CanvasElement(type: .extractImage(Image(uiImage: uiImage)))
//									self.addedCanvasElements.append(canvasElement)
//									self.currentEditingCanvasElement = canvasElement
								}
							}
							// TODO: source가 초기화 되지 않았을 경우 예외처리
						}
					}
				case .failure(let error):
					print("Failed to load photo: \(error)")
				}
			}
			selectedPhotosItems = []
		}
	}
}
