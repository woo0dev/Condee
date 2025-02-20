//
//  BackgroundImageGestureModifier.swift
//  Condee
//
//  Created by woo0 on 12/5/24.
//

import SwiftUI

struct BackgroundImageGestureModifier: ViewModifier {
	@Binding var backgroundImageRect: CGRect
	@Binding var cropRect: CGRect
	
	@State private var imageSize: CGSize = .zero
	@State private var isHorizontalScroll: Bool = false
	
	let canvasSize: CGSize
	
	func body(content: Content) -> some View {
		GeometryReader { geometry in
			ScrollView(isHorizontalScroll ? .horizontal : .vertical, showsIndicators: false) {
				content
					.if(imageSize != .zero) { view in
						view.frame(width: imageSize.width, height: imageSize.height)
					}
					.background(
						GeometryReader { backgroundGeometry in
							Color.clear
								.onAppear {
									let widthRatio = canvasSize.width / backgroundGeometry.size.width
									let heightRatio = canvasSize.height / backgroundGeometry.size.height
									let scaleFactor = max(widthRatio, heightRatio)
									isHorizontalScroll = widthRatio < heightRatio
									imageSize = CGSize(width: backgroundGeometry.size.width * scaleFactor, height: backgroundGeometry.size.height * scaleFactor)
									
									let x = ceil(abs(geometry.frame(in: .global).minX - geometry.frame(in: .global).minX))
									let y = ceil(abs(geometry.frame(in: .global).minY - geometry.frame(in: .global).minY))
									backgroundImageRect = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
								}
								.onChange(of: backgroundGeometry.frame(in: .global)) {
									let x = ceil(abs(backgroundGeometry.frame(in: .global).minX - geometry.frame(in: .global).minX))
									let y = ceil(abs(backgroundGeometry.frame(in: .global).minY - geometry.frame(in: .global).minY))
									cropRect = CGRect(x: x, y: y, width: geometry.size.width, height: geometry.size.height)
								}
						}
					)
			}
		}
	}
}
