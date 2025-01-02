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
	@Published var cropRect: CGRect = .zero
	@Published var imageRect: CGRect = .zero
	@Published var extractImage: UIImage? = nil
	@Published var extractedImages: [UIImage] = []
	@Published var selectedExtractedImage: UIImage? = nil
	@Published var isExtracting: Bool = false
	@Published var isEditing: Bool = false
	
	private let createCustomImageSceneViewModel: CreateCustomImageSceneViewModel
	private let adjustContrastUseCase: AdjustContrastUseCase
	private let cropImageUseCase: CropImageUseCase
	private let extractTextUseCase: ExtractTextUseCase
	private let imageResizingUseCase: ImageResizingUseCase
	private let eraseImageUseCase: EraseImageUseCase
	
	init(createCustomImageSceneViewModel: CreateCustomImageSceneViewModel, adjustContrastUseCase: AdjustContrastUseCase, cropImageUseCase: CropImageUseCase, extractTextUseCase: ExtractTextUseCase, imageResizingUseCase: ImageResizingUseCase, eraseImageUseCase: EraseImageUseCase) {
		self.createCustomImageSceneViewModel = createCustomImageSceneViewModel
		self.adjustContrastUseCase = adjustContrastUseCase
		self.cropImageUseCase = cropImageUseCase
		self.extractTextUseCase = extractTextUseCase
		self.imageResizingUseCase = imageResizingUseCase
		self.eraseImageUseCase = eraseImageUseCase
		extractImage = getTextExtractionImage()
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
			createCustomImageSceneViewModel.doneImageExtraction(image: Image(uiImage: image))
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
