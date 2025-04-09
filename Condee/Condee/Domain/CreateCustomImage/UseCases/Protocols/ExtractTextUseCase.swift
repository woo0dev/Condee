//
//  ExtractTextUseCase.swift
//  Condee
//
//  Created by woo0 on 12/20/24.
//

import SwiftUI

protocol ExtractTextUseCase {
	func execute(image: UIImage) -> [UIImage]
}
