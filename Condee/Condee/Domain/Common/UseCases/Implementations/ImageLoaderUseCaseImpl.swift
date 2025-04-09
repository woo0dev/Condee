//
//  ImageLoaderUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 1/16/25.
//

import Combine
import SwiftUI

final class ImageLoaderUseCaseImpl: ImageLoaderUseCase {
	private let repository: ImageRepository
	
	init(repository: ImageRepository) {
		self.repository = repository
	}
	
	func execute(from customImages: [CustomImage]) -> AnyPublisher<[UIImage?], Never> {
		return repository.fetchImages(from: customImages)
	}
	
	func execute(from url: URL) -> AnyPublisher<UIImage?, Never> {
		return repository.fetchImage(from: url)
	}
}
