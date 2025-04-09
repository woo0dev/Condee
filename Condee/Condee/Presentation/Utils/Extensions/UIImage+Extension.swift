//
//  UIImage+Extension.swift
//  Condee
//
//  Created by woo0 on 1/2/25.
//

import UIKit

extension UIImage {
	func croppedToContent() -> UIImage? {
		guard let cgImage = self.cgImage else { return nil }
		
		let width = cgImage.width
		let height = cgImage.height
		
		guard let dataProvider = cgImage.dataProvider, let pixelData = dataProvider.data else {
			return nil
		}
		
		let pixels = CFDataGetBytePtr(pixelData)
		
		var top: Int? = nil
		var left: Int? = nil
		var bottom: Int? = nil
		var right: Int? = nil
		
		for y in 0..<height {
			for x in 0..<width {
				let pixelIndex = (y * width + x) * 4
				let alpha = pixels?[pixelIndex + 3]
				
				if let alpha = alpha, alpha > 0 {
					if top == nil { top = y }
					if left == nil || x < left! { left = x }
					if bottom == nil || y > bottom! { bottom = y }
					if right == nil || x > right! { right = x }
				}
			}
		}
		
		guard let top = top, let left = left, let bottom = bottom, let right = right else {
			return self
		}
		
		let cropRect = CGRect(x: left, y: top, width: right - left, height: bottom - top)
		
		if let croppedCgImage = cgImage.cropping(to: cropRect) {
			return UIImage(cgImage: croppedCgImage)
		}
		
		return nil
	}
}

