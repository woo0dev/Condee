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
	@State var eraserSize: CGFloat = 40
	
	let image: UIImage
	
	var body: some View {
		VStack {
			Spacer()
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
			.background(GridPatternBackgroundView(color: $viewModel.gridPatternColor).clipped())
			Spacer()
			HStack {
				Spacer()
				Button(action: viewModel.toggleGridPatternColor, label: {
					GridPatternBackgroundView(color: $viewModel.gridPatternColor)
						.frame(width: 40, height: 40)
						.cornerRadius(20)
						.overlay(Circle().stroke(Color.gray, lineWidth: 2))
				})
				Circle()
					.fill(.primary)
					.frame(width: eraserSize, height: eraserSize)
				Text(String(format: "%.0f", eraserSize))
				ResizeButton(size: $eraserSize, minSize: 10, maxSize: 40)
			}
			.frame(height: 50)
			.padding(.horizontal, 20)
			.padding(.bottom)
		}
	}
}
