//
//  ImageResizingUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 12/23/24.
//

import SwiftUI

final class ImageResizingUseCaseImpl: ImageResizingUseCase {
	private let maxSize: CGFloat
	
	init(maxSize: CGFloat = 1000) {
		self.maxSize = maxSize
	}
	
	func execute(image: UIImage) -> UIImage? {
		let width = image.size.width
		let height = image.size.height
		
		let maxDimension = max(width, height)
		
		if maxDimension <= maxSize {
			return image
		}
		
		let scale = maxSize / maxDimension
		
		let newWidth = width * scale
		let newHeight = height * scale
		
		UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, image.scale)
		image.draw(in: CGRect(origin: .zero, size: CGSize(width: newWidth, height: newHeight)))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return resizedImage
	}
}
