//
//  AdjustContrastUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 12/20/24.
//

import SwiftUI

final class AdjustContrastUseCaseImpl: AdjustContrastUseCase {
	func execute(image: UIImage) -> UIImage? {
		guard let ciImage = CIImage(image: image) else { return nil }
		let filter = CIFilter(name: "CIColorControls")
		filter?.setValue(ciImage, forKey: kCIInputImageKey)
		filter?.setValue(1.5, forKey: kCIInputContrastKey)

		guard let outputImage = filter?.outputImage else { return nil }
		let context = CIContext()
		
		if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
			return UIImage(cgImage: cgImage)
		}
		
		return nil
	}
}
