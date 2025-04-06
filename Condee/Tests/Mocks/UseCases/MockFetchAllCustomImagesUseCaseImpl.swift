//
//  MockFetchAllCustomImagesUseCaseImpl.swift
//  CondeeTests
//
//  Created by woo0 on 3/27/25.
//

import Combine

@testable import Condee

final class MockFetchAllCustomImagesUseCaseImpl: FetchAllCustomImagesUseCase {
	private let repository: CustomImageRepository

	init(repository: CustomImageRepository) {
		self.repository = repository
	}

	func execute() -> AnyPublisher<[CustomImage], Error> {
		return repository.fetchAll()
	}
}
