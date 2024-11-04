//
//  CreateCustomImageUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 11/3/24.
//

import Combine
import Foundation

final class CreateCustomImageUseCaseImpl: CreateCustomImageUseCase {
	private let repository: CustomImageRepository

	init(repository: CustomImageRepository) {
		self.repository = repository
	}

	func execute(imageURL: URL) -> AnyPublisher<Void, Error> {
		let customImage = CustomImage(imageURL: imageURL)
		return repository.create(customImage: customImage)
	}
}
