//
//  ImageFixingUseCase.swift
//  Condee
//
//  Created by woo0 on 1/11/25.
//

import SwiftUI

protocol ImageFixingUseCase {
	func execute(image: UIImage) -> UIImage
}
