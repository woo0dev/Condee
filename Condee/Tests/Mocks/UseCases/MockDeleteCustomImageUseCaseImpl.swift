//
//  MockDeleteCustomImageUseCaseImpl.swift
//  CondeeTests
//
//  Created by woo0 on 3/27/25.
//

import Combine

@testable import Condee

final class MockDeleteCustomImageUseCaseImpl: DeleteCustomImageUseCase {
	private let repository: CustomImageRepository

	init(repository: CustomImageRepository) {
		self.repository = repository
	}

	func execute(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		return repository.delete(customImage: customImage)
	}
}
