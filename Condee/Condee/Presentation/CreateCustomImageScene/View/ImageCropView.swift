//
//  ImageCropView.swift
//  Condee
//
//  Created by woo0 on 12/18/24.
//

import SwiftUI

struct ImageCropView: View {
	@State private var imageFrame: CGRect = .zero
	@State private var lastDragPosition: CGPoint = .zero
	
	@Binding var cropRect: CGRect
	@State var image: UIImage
	
	var body: some View {
		VStack {
			GeometryReader { geometry in
				ZStack {
					Image(uiImage: image)
						.resizable()
						.scaledToFit()
						.background(
							GeometryReader { contentGeometry in
								Color.clear
									.onAppear {
										let width = contentGeometry.size.width
										let height = contentGeometry.size.height
										let xOffset = (geometry.size.width - width) / 2
										let yOffset = (geometry.size.height - height) / 2
										
										imageFrame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
										cropRect = imageFrame
									}
							}
						)
					
					Color.gray.opacity(0.5)
						.frame(width: imageFrame.size.width, height: imageFrame.size.height)
					
					Image(uiImage: image)
						.resizable()
						.scaledToFit()
						.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
						.mask(
							Rectangle()
								.frame(width: cropRect.size.width, height: cropRect.size.height)
								.position(x: cropRect.midX, y: cropRect.midY)
						)
					
					Color.clear
						.contentShape(Rectangle())
						.border(.secondary, width: 1)
						.frame(width: cropRect.size.width, height: cropRect.size.height)
						.position(x: cropRect.midX, y: cropRect.midY)
						.gesture(
							DragGesture()
								.onChanged { value in
									if lastDragPosition == .zero {
										lastDragPosition = cropRect.origin
									}
									
									let newX = lastDragPosition.x + value.translation.width
									let newY = lastDragPosition.y + value.translation.height
									
									cropRect.origin.x = min(max(newX, imageFrame.origin.x), imageFrame.maxX - cropRect.width)
									cropRect.origin.y = min(max(newY, imageFrame.origin.y), imageFrame.maxY - cropRect.height)
								}
								.onEnded { _ in
									lastDragPosition = cropRect.origin
								})
					cornerResizeHandles(geometry: geometry)
				}
				.frame(width: geometry.size.width, height: geometry.size.height)
			}
			.padding(20)
		}
	}
	
	func cornerResizeHandles(geometry: GeometryProxy) -> some View {
		Group {
			Image("TopLeadingCorner")
				.renderingMode(.template)
				.position(x: cropRect.origin.x + 10, y: cropRect.origin.y + 10)
				.gesture(DragGesture()
					.onChanged { value in
						let newWidth = cropRect.size.width + (cropRect.origin.x - value.location.x)
						let newHeight = cropRect.size.height + (cropRect.origin.y - value.location.y)
						let newX = value.location.x
						let newY = value.location.y
						
						cropRect.origin.x = max(imageFrame.minX, min(newX, imageFrame.maxX - 20))
						cropRect.origin.y = max(imageFrame.minY, min(newY, imageFrame.maxY - 20))
						cropRect.size.width = max(20, min(newWidth, imageFrame.maxX - cropRect.origin.x))
						cropRect.size.height = max(20, min(newHeight, imageFrame.maxY - cropRect.origin.y))
					})
			
			Image("TopTrailingCorner")
				.renderingMode(.template)
				.position(x: cropRect.origin.x + cropRect.width - 10, y: cropRect.origin.y + 10)
				.gesture(DragGesture()
					.onChanged { value in
						let newWidth = value.location.x - cropRect.origin.x
						let newHeight = cropRect.size.height + (cropRect.origin.y - value.location.y)
						let newX = cropRect.origin.x
						let newY = value.location.y

						cropRect.origin.x = max(imageFrame.minX, min(newX, imageFrame.maxX - 20))
						cropRect.origin.y = max(imageFrame.minY, min(newY, imageFrame.maxY - 20))
						cropRect.size.width = max(20, min(newWidth, imageFrame.maxX - cropRect.origin.x))
						cropRect.size.height = max(20, min(newHeight, imageFrame.maxY - cropRect.origin.y))
					})
			
			Image("BottomLeadingCorner")
				.renderingMode(.template)
				.position(x: cropRect.origin.x + 10, y: cropRect.origin.y + cropRect.height - 10)
				.gesture(DragGesture()
					.onChanged { value in
						let newWidth = cropRect.size.width + (cropRect.origin.x - value.location.x)
						let newHeight = value.location.y - cropRect.origin.y
						let newX = value.location.x
						let newY = cropRect.origin.y

						cropRect.origin.x = max(imageFrame.minX, min(newX, imageFrame.maxX - 20))
						cropRect.origin.y = max(imageFrame.minY, min(newY, imageFrame.maxY - 20))
						cropRect.size.width = max(20, min(newWidth, imageFrame.maxX - cropRect.origin.x))
						cropRect.size.height = max(20, min(newHeight, imageFrame.maxY - cropRect.origin.y))
					})
			
			Image("BottomTrailingCorner")
				.renderingMode(.template)
				.position(x: cropRect.origin.x + cropRect.width - 10, y: cropRect.origin.y + cropRect.height - 10)
				.gesture(DragGesture()
					.onChanged { value in
						let newWidth = value.location.x - cropRect.origin.x
						let newHeight = value.location.y - cropRect.origin.y
						let newX = cropRect.origin.x
						let newY = cropRect.origin.y

						cropRect.origin.x = max(imageFrame.minX, min(newX, imageFrame.maxX - 20))
						cropRect.origin.y = max(imageFrame.minY, min(newY, imageFrame.maxY - 20))
						cropRect.size.width = max(20, min(newWidth, imageFrame.maxX - cropRect.origin.x))
						cropRect.size.height = max(20, min(newHeight, imageFrame.maxY - cropRect.origin.y))
					})
		}
		.foregroundColor(.primary)
	}
}
