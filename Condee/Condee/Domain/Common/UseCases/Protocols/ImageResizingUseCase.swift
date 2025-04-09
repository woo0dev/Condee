//
//  ImageResizingUseCase.swift
//  Condee
//
//  Created by woo0 on 12/23/24.
//

import SwiftUI

protocol ImageResizingUseCase {
	func execute(image: UIImage) -> UIImage?
}
