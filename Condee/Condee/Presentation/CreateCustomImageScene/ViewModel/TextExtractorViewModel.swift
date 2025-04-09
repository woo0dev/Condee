//
//  TextExtractorViewModel.swift
//  Condee
//
//  Created by woo0 on 12/19/24.
//

import SwiftUI
import Vision
import opencv2

@MainActor
final class TextExtractorViewModel: ObservableObject {
	@Published var gridPatternColor: Color = .white
	@Published var cropRect: CGRect = .zero
	@Published var imageRect: CGRect = .zero
	@Published var extractImage: UIImage? = nil
	@Published var extractedImages: [UIImage] = []
	@Published var selectedExtractedImage: UIImage? = nil
	@Published var lastColorChangeTime: Date? = nil
	@Published var timeUntilColorChange: Int = 0
	@Published var toastMessage: String = ""
	
	@Published var isExtracting: Bool = false
	@Published var isEditing: Bool = false
	@Published var isToastPresented: Bool = false
	
	private let createCustomImageSceneViewModel: CreateCustomImageSceneViewModel
	private let adjustContrastUseCase: AdjustContrastUseCase
	private let cropImageUseCase: CropImageUseCase
	private let extractTextUseCase: ExtractTextUseCase
	private let imageResizingUseCase: ImageResizingUseCase
	private let removeEmptySpaceUseCase: RemoveEmptySpaceUseCase
	private let eraseImageUseCase: EraseImageUseCase
	
	init( createCustomImageSceneViewModel: CreateCustomImageSceneViewModel, adjustContrastUseCase: AdjustContrastUseCase, cropImageUseCase: CropImageUseCase, extractTextUseCase: ExtractTextUseCase, imageResizingUseCase: ImageResizingUseCase, removeEmptySpaceUseCase: RemoveEmptySpaceUseCase, eraseImageUseCase: EraseImageUseCase) {
		self.createCustomImageSceneViewModel = createCustomImageSceneViewModel
		self.adjustContrastUseCase = adjustContrastUseCase
		self.cropImageUseCase = cropImageUseCase
		self.extractTextUseCase = extractTextUseCase
		self.imageResizingUseCase = imageResizingUseCase
		self.removeEmptySpaceUseCase = removeEmptySpaceUseCase
		self.eraseImageUseCase = eraseImageUseCase
		extractImage = getTextExtractionImage()
	}
	
	func toggleGridPatternColor() {
		if let lastColorChangeTime = lastColorChangeTime {
			timeUntilColorChange = Int(Date.now.timeIntervalSince(lastColorChangeTime)) - 5
		}
		if timeUntilColorChange >= 0 || lastColorChangeTime == Date.now {
			if gridPatternColor == .white {
				gridPatternColor = .black
			} else {
				gridPatternColor = .white
			}
			lastColorChangeTime = Date.now
		} else {
			isToastPresented = true
			toastMessage = "\(abs(timeUntilColorChange))초 후에 다시 시도해주세요."
		}
	}
	
	func getTextExtractionImage() -> UIImage? {
		guard let extractUIImage = createCustomImageSceneViewModel.extractUIImage else { return nil }
		
		let resizedImage = imageResizingUseCase.execute(image: extractUIImage)
		extractImage = resizedImage
		
		return resizedImage
	}
	
	func cancleTapped() {
		createCustomImageSceneViewModel.cancleImageExtraction()
	}
	
	func doneTapped() {
		if let image = selectedExtractedImage?.croppedToContent() {
			if let finalImage = removeEmptySpaceUseCase.execute(from: image) {
				createCustomImageSceneViewModel.doneImageExtraction(image: Image(uiImage: finalImage))
			} else {
				createCustomImageSceneViewModel.doneImageExtraction(image: Image(uiImage: image))
			}
		} else {
			createCustomImageSceneViewModel.cancleImageExtraction()
		}
	}
	
	func editTapped() {
		isEditing = true
	}
	
	func eraseImage(at point: CGPoint, eraserSize: CGFloat, imageViewSize: CGSize) {
		guard let image = selectedExtractedImage else { return }
		selectedExtractedImage = eraseImageUseCase.execute(image: image, at: point, eraserSize: eraserSize, imageViewSize: imageViewSize)
	}
	
	func extractTapped() {
		isExtracting = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			guard let image = self.extractImage else { return }
			let cropImage = self.cropImageUseCase.execute(image: image, cropRect: self.cropRect, imageRect: self.imageRect)
			guard let adjustImage = self.adjustContrastUseCase.execute(image: cropImage) else { return }
			self.extractedImages = self.extractTextUseCase.execute(image: adjustImage)
			self.selectedExtractedImage = self.extractedImages.first
			self.isExtracting = false
		}
	}
}
