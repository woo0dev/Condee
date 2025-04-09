//
//  ImageFixingUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 1/11/25.
//

import SwiftUI

final class ImageFixingUseCaseImpl: ImageFixingUseCase {
	func execute(image: UIImage) -> UIImage {
		if image.imageOrientation == .up { return image }
		
		UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
		image.draw(in: CGRect(origin: .zero, size: image.size))
		let fixedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return fixedImage ?? image
	}
}
