//
//  EraseImageUseCase.swift
//  Condee
//
//  Created by woo0 on 12/27/24.
//

import SwiftUI

protocol EraseImageUseCase {
	func execute(image: UIImage, at point: CGPoint, eraserSize: CGFloat, imageViewSize: CGSize) -> UIImage
}
