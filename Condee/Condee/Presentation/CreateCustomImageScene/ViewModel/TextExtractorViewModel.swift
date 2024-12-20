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
	@Published var selectedExtractedImage: UIImage? = nil
	
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
		guard let image = createCustomImageSceneViewModel.extractUIImage else { return }
		let cropImage = cropImageUseCase.execute(image: image, cropRect: cropRect, imageRect: imageRect)
		guard let adjustImage = adjustContrastUseCase.execute(image: cropImage) else { return }
		selectedExtractedImage = extractTextUseCase.execute(image: adjustImage).last
	}
}

