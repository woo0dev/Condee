//
//  RemoveEmptySpaceUseCase.swift
//  Condee
//
//  Created by woo0 on 1/13/25.
//

import SwiftUI

protocol RemoveEmptySpaceUseCase {
	func execute(from image: UIImage) -> UIImage?
}
