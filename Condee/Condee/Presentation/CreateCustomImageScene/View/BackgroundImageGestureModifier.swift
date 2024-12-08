//
//  BackgroundImageGestureModifier.swift
//  Condee
//
//  Created by woo0 on 12/5/24.
//

import SwiftUI

struct BackgroundImageGestureModifier: ViewModifier {
	@State private var imageSize: CGSize = .zero
	@State private var isHorizontalScroll: Bool = false
	
	let canvasSize: CGSize
	
	func body(content: Content) -> some View {
		ScrollView(isHorizontalScroll ? .horizontal : .vertical) {
			content
				.if(imageSize != .zero) { view in
					view.frame(width: imageSize.width, height: imageSize.height)
				}
				.background(
					GeometryReader { geometry in
						Color.clear
							.onAppear {
								let widthRatio = canvasSize.width / geometry.size.width
								let heightRatio = canvasSize.height / geometry.size.height
								let scaleFactor = max(widthRatio, heightRatio)
								isHorizontalScroll = widthRatio < heightRatio
								imageSize = CGSize(width: geometry.size.width * scaleFactor, height: geometry.size.height * scaleFactor)
							}
					}
				)
		}
	}
}
