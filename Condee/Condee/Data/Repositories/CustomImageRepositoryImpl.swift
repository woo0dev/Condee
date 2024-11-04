//
//  CustomImageRepositoryImpl.swift
//  Condee
//
//  Created by woo0 on 11/3/24.
//

import Combine
import SwiftData

final class CustomImageRepositoryImpl: CustomImageRepository {
	private var modelContext: ModelContext
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}

	func create(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		modelContext.insert(customImage)
		return Future { promise in
			do {
				try self.modelContext.save()
				promise(.success(()))
			} catch {
				promise(.failure(error))
			}
		}
		.eraseToAnyPublisher()
	}

	func delete(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		modelContext.delete(customImage)
		return Future { promise in
			do {
				try self.modelContext.save()
				promise(.success(()))
			} catch {
				promise(.failure(error))
			}
		}
		.eraseToAnyPublisher()
	}
}
