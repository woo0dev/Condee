//
//  EraseImageUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 12/27/24.
//

import SwiftUI

final class EraseImageUseCaseImpl: EraseImageUseCase {
	func execute(image: UIImage, at point: CGPoint, eraserSize: CGFloat, imageViewSize: CGSize) -> UIImage {
		let scaleX = image.size.width / imageViewSize.width
		let scaleY = image.size.height / imageViewSize.height
		
		let imagePoint = CGPoint(x: point.x * scaleX, y: point.y * scaleY)
		let imageEraserSize = eraserSize * max(scaleX, scaleY)
		let renderer = UIGraphicsImageRenderer(size: image.size)
		
		let newImage = renderer.image { rendererContext in
			image.draw(at: .zero)
			
			let context = rendererContext.cgContext
			context.setBlendMode(.clear)
			
			let rect = CGRect(
				x: imagePoint.x - imageEraserSize / 2,
				y: imagePoint.y - imageEraserSize / 2,
				width: imageEraserSize,
				height: imageEraserSize
			)
			
			context.fillEllipse(in: rect)
		}
		
		return newImage
	}
}
