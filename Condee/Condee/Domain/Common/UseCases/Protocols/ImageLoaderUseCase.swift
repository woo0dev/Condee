//
//  ImageLoaderUseCase.swift
//  Condee
//
//  Created by woo0 on 1/16/25.
//

import Combine
import SwiftUI

protocol ImageLoaderUseCase {
	func execute(from customImages: [CustomImage]) -> AnyPublisher<[UIImage?], Never>
	func execute(from url: URL) -> AnyPublisher<UIImage?, Never>
}
