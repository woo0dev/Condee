//
//  ImageRepository.swift
//  Condee
//
//  Created by woo0 on 1/16/25.
//

import Combine
import SwiftUI

protocol ImageRepository {
	func fetchImages(from customImages: [CustomImage]) -> AnyPublisher<[UIImage?], Never>
	func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}
