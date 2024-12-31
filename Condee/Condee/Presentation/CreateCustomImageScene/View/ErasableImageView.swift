//
//  ErasableImageView.swift
//  Condee
//
//  Created by woo0 on 12/27/24.
//

import SwiftUI

struct ErasableImageView: View {
	@ObservedObject var viewModel: TextExtractorViewModel
	
	@State private var currentPoint: CGPoint? = nil
	@State private var lastPoint: CGPoint? = nil
	@State var imageViewSize: CGSize = .zero
	
	let eraserSize: CGFloat = 50
	let image: UIImage
	@State var count = 0
	
	var body: some View {
		ZStack {
			Image(uiImage: image)
				.resizable()
				.scaledToFit()
				.background(
					GeometryReader { contentGeometry in
						Color.clear
							.onAppear {
								imageViewSize = CGSize(width: contentGeometry.size.width, height: contentGeometry.size.height)
							}
					}
				)
				.gesture(
					DragGesture(minimumDistance: 0)
						.onChanged { value in
							let tapPoint = CGPoint(x: max(min(value.location.x, imageViewSize.width), 0), y: max(min(value.location.y, imageViewSize.height), 0))
							let distance = sqrt(pow(tapPoint.x - (lastPoint?.x ?? 0), 2) + pow(tapPoint.y - (lastPoint?.y ?? 0), 2))
							
							if distance > 5 {
								viewModel.eraseImage(at: tapPoint, eraserSize: eraserSize, imageViewSize: imageViewSize)
								lastPoint = tapPoint
							}
							currentPoint = tapPoint
						}
						.onEnded { _ in
							lastPoint = nil
							currentPoint = nil
						}
				)
			if let currentPoint = currentPoint {
				Circle()
					.fill(.white)
					.frame(width: eraserSize, height: eraserSize)
					.position(currentPoint)
			}
		}
		.frame(width: imageViewSize == .zero ? UIScreen.main.bounds.width : imageViewSize.width, height: imageViewSize == .zero ? UIScreen.main.bounds.height : imageViewSize.height )
	}
}
