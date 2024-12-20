//
//  CropImageUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 12/19/24.
//

import SwiftUI

final class CropImageUseCaseImpl: CropImageUseCase {
	func execute(image: UIImage, cropRect: CGRect, imageRect: CGRect) -> UIImage {
		let scaleX = image.size.width / imageRect.width
		let scaleY = image.size.height / imageRect.height
		
		let adjustedOriginX = (cropRect.origin.x - imageRect.origin.x) * scaleX
		let adjustedOriginY = (cropRect.origin.y - imageRect.origin.y) * scaleY
		let adjustedWidth = cropRect.size.width * scaleX
		let adjustedHeight = cropRect.size.height * scaleY
		
		let newCropRect = CGRect(x: adjustedOriginX, y: adjustedOriginY, width: adjustedWidth, height: adjustedHeight)
		
		if let cgImage = image.cgImage?.cropping(to: newCropRect) {
			return UIImage(cgImage: cgImage)
		} else {
			print("Cropping failed")
			return image
		}
	}
}
