//
//  TextExtractorViewModel.swift
//  Condee
//
//  Created by woo0 on 12/19/24.
//

import SwiftUI

@MainActor
final class TextExtractorViewModel: ObservableObject {
	@Published var addedCanvasElements: [CanvasElement]
	@Published var currentEditingCanvasElement: CanvasElement?
	
	@Published var extractUIImage: UIImage?
	@Published var cropRect: CGRect = .zero
	
	@Published var isExtractImageModalPresented: Bool
	
	private let cropImageUseCase: CropImageUseCase
	
	init(addedCanvasElements: [CanvasElement], currentEditingCanvasElement: CanvasElement? = nil, extractUIImage: UIImage? = nil, isExtractImageModalPresented: Bool, cropImageUseCase: CropImageUseCase) {
		self.addedCanvasElements = addedCanvasElements
		self.currentEditingCanvasElement = currentEditingCanvasElement
		self.extractUIImage = extractUIImage
		self.cropImageUseCase = cropImageUseCase
		self.isExtractImageModalPresented = isExtractImageModalPresented
	}
	
	func tappedCancleButton() {
		isExtractImageModalPresented = false
	}
	
	func tappedExtractCompleteButton() {
		
	}
	
	// TODO: crop 후 바로 extract 하도록 수정
	func cropImage() {
		if let image = extractUIImage {
			extractUIImage = cropImageUseCase.execute(image: image, cropRect: cropRect)
		}
	}
}

