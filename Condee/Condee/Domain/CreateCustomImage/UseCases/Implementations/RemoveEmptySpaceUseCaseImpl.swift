//
//  RemoveEmptySpaceUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 1/13/25.
//

import SwiftUI

final class RemoveEmptySpaceUseCaseImpl: RemoveEmptySpaceUseCase {
	func execute(from image: UIImage) -> UIImage? {
		guard let cgImage = image.cgImage else { return nil }
		let width = cgImage.width
		let height = cgImage.height
		
		var minX = width, minY = height, maxX = 0, maxY = 0
		let data = cgImage.dataProvider?.data
		let pixelData = CFDataGetBytePtr(data)
		let bytesPerRow = cgImage.bytesPerRow
		
		for y in 0..<height {
			for x in 0..<width {
				let pixelIndex = y * bytesPerRow + x * 4
				let alpha = pixelData?[pixelIndex + 3] ?? 0
				if alpha > 0 {
					minX = min(minX, x)
					minY = min(minY, y)
					maxX = max(maxX, x)
					maxY = max(maxY, y)
				}
			}
		}
		
		let cropRect = CGRect(x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1)
		guard let croppedCGImage = cgImage.cropping(to: cropRect) else { return nil }
		
		return UIImage(cgImage: croppedCGImage)
	}
}
