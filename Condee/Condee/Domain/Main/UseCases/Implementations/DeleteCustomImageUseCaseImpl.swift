//
//  DeleteCustomImageUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 11/3/24.
//

import Combine

final class DeleteCustomImageUseCaseImpl: DeleteCustomImageUseCase {
	private let repository: CustomImageRepository

	init(repository: CustomImageRepository) {
		self.repository = repository
	}

	func execute(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		return repository.delete(customImage: customImage)
	}
}
