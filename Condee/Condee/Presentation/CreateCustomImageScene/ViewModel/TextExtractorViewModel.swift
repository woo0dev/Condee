//
//  TextExtractorViewModel.swift
//  Condee
//
//  Created by woo0 on 12/19/24.
//

import SwiftUI

@MainActor
final class TextExtractorViewModel: ObservableObject {
	@Published var cropRect: CGRect = .zero
	@Published var imageRect: CGRect = .zero
	@Published var extractedImages: [UIImage] = []
	@Published var selectedExtractedImage: UIImage? = nil
	@Published var isExtracting: Bool = false
	
	private let createCustomImageSceneViewModel: CreateCustomImageSceneViewModel
	private let adjustContrastUseCase: AdjustContrastUseCase
	private let cropImageUseCase: CropImageUseCase
	private let extractTextUseCase: ExtractTextUseCase
	
	init(createCustomImageSceneViewModel: CreateCustomImageSceneViewModel, adjustContrastUseCase: AdjustContrastUseCase, cropImageUseCase: CropImageUseCase, extractTextUseCase: ExtractTextUseCase) {
		self.createCustomImageSceneViewModel = createCustomImageSceneViewModel
		self.adjustContrastUseCase = adjustContrastUseCase
		self.cropImageUseCase = cropImageUseCase
		self.extractTextUseCase = extractTextUseCase
	}
	
	func getTextExtractionImage() -> UIImage? {
		return createCustomImageSceneViewModel.extractUIImage
	}
	
	func cancleTapped() {
		createCustomImageSceneViewModel.cancleImageExtraction()
	}
	
	func doneTapped() {
		if let image = selectedExtractedImage {
			createCustomImageSceneViewModel.doneImageExtraction(image: Image(uiImage: image))
		} else {
			createCustomImageSceneViewModel.cancleImageExtraction()
		}
	}
	
	func extractTapped() {
		isExtracting = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			guard let image = self.getTextExtractionImage() else { return }
			let cropImage = self.cropImageUseCase.execute(image: image, cropRect: self.cropRect, imageRect: self.imageRect)
			guard let adjustImage = self.adjustContrastUseCase.execute(image: cropImage) else { return }
			self.extractedImages = self.extractTextUseCase.execute(image: adjustImage)
			self.selectedExtractedImage = self.extractedImages.first
			self.isExtracting = false
		}
	}
}
