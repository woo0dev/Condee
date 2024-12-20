//
//  CropImageUseCase.swift
//  Condee
//
//  Created by woo0 on 12/19/24.
//

import SwiftUI

protocol CropImageUseCase {
	func execute(image: UIImage, cropRect: CGRect, imageRect: CGRect) -> UIImage
}
