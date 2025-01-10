//
//  CreateCustomImageSceneViewModel.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import Combine
import SwiftUI
import PhotosUI

@MainActor
final class CreateCustomImageSceneViewModel: ObservableObject {
	@Published var selectedPhotosItems: [PhotosPickerItem] = []
	@Published var imageSource: ImageSource? = nil
	@Published var actionSheetType: ActionSheetType? = nil
	
	@Published var createImage: Image? = nil
	@Published var selectedBackgroundImage: UIImage? = nil
	@Published var addedCanvasElements: [CanvasElement] = []
	@Published var currentEditingCanvasElement: CanvasElement? = nil
	@Published var extractUIImage: UIImage? = nil
	
	@Published var isDetailCustomImageViewPresented: Bool = false
	@Published var isDoneButtonTapped: Bool = false
	@Published var isPhotosPickerPresented: Bool = false
	@Published var isActionSheetPresented: Bool = false
	@Published var isStickerHalfModalPresented: Bool = false
	@Published var isExtractImageModalPresented: Bool = false
	@Published var isDirectInputModalPresented: Bool = false
	@Published var isColorPickerPresented: Bool = false
	
	private let cropImageUseCase: CropImageUseCase
	private let imageFixingUseCase: ImageFixingUseCase
	private let updateTextUseCase: UpdateCanvasElementTextUseCase
	
	init(cropImageUseCase: CropImageUseCase, imageFixingUseCase: ImageFixingUseCase, updateTextUseCase: UpdateCanvasElementTextUseCase) {
		self.cropImageUseCase = cropImageUseCase
		self.imageFixingUseCase = imageFixingUseCase
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
	
	func cancleImageExtraction() {
		isExtractImageModalPresented = false
	}
	
	func doneImageExtraction(image: Image) {
		let canvasElement = CanvasElement(type: .extractImage(image))
		addedCanvasElements.append(canvasElement)
		currentEditingCanvasElement = canvasElement
		isExtractImageModalPresented = false
	}
	
	func doneTapped() {
		currentEditingCanvasElement = nil
		isDoneButtonTapped = true
	}
	
	func createResultImage(view: some View, size: CGSize, cropRect: CGRect, imageRect: CGRect) {
		guard let backgroundImage = selectedBackgroundImage else { return }
		let fixedImage = imageFixingUseCase.execute(image: backgroundImage)
		selectedBackgroundImage = cropImageUseCase.execute(image: fixedImage, cropRect: cropRect, imageRect: imageRect)
		
		let renderer = ImageRenderer(content: view)
		renderer.scale = UIScreen.main.scale
		renderer.proposedSize = .init(size)
		if let uiimage = renderer.uiImage {
			createImage = Image(uiImage: uiimage)
			isDetailCustomImageViewPresented = true
			isDoneButtonTapped = false
		}
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
									self.selectedBackgroundImage = uiImage
								case .additionalImage:
									let canvasElement = CanvasElement(type: .additionalImage(Image(uiImage: uiImage)))
									self.addedCanvasElements.append(canvasElement)
									self.currentEditingCanvasElement = canvasElement
								case .extractImage:
									self.isExtractImageModalPresented = true
									self.extractUIImage = uiImage
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
