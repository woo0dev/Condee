//
//  FetchAllCustomImagesUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import Combine

final class FetchAllCustomImagesUseCaseImpl: FetchAllCustomImagesUseCase {
	private let repository: CustomImageRepository

	init(repository: CustomImageRepository) {
		self.repository = repository
	}

	func execute() -> AnyPublisher<[CustomImage], Error> {
		return repository.fetchAll()
	}
}
