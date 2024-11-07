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
	
	func fetchAll() -> AnyPublisher<[CustomImage], Error> {
		return Future { promise in
			do {
				let customImages = try self.modelContext.fetch(FetchDescriptor<CustomImage>())
				promise(.success(customImages))
			} catch {
				promise(.failure(error))
			}
		}
		.eraseToAnyPublisher()
	}

	func create(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		return Future { promise in
			do {
				self.modelContext.insert(customImage)
				try self.modelContext.save()
				promise(.success(()))
			} catch {
				promise(.failure(error))
			}
		}
		.eraseToAnyPublisher()
	}

	func delete(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		return Future { promise in
			do {
				self.modelContext.delete(customImage)
				try self.modelContext.save()
				promise(.success(()))
			} catch {
				promise(.failure(error))
			}
		}
		.eraseToAnyPublisher()
	}
}
