//
//  CropImageUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 12/19/24.
//

import SwiftUI

final class CropImageUseCaseImpl: CropImageUseCase {
	func execute(image: UIImage, cropRect: CGRect) -> UIImage {
		if let cgImage = image.cgImage?.cropping(to: cropRect) {
			return UIImage(cgImage: cgImage)
		} else {
			print("Cropping failed")
			return image
		}
	}
}
