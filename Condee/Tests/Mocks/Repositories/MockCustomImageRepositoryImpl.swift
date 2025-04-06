//
//  MockCustomImageRepositoryImpl.swift
//  CondeeTests
//
//  Created by woo0 on 3/27/25.
//

import SwiftUI
import Combine

@testable import Condee

final class MockCustomImageRepositoryImpl: CustomImageRepository {
	var customImages: [CustomImage] = []
	var images: [UIImage?] = []
	
	init() {
		let sampleURL = URL(string: "https://picsum.photos/200/300")!
		let sampleImage = UIImage(systemName: "photo")
		for _ in 0..<6 {
			let customImage = CustomImage(id: UUID(), imageURL: sampleURL)
			customImages.append(customImage)
			images.append(sampleImage)
		}
	}
	
	func fetchAll() -> AnyPublisher<[CustomImage], Error> {
		return Just(customImages)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
	
	func create(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		return Future { promise in
			self.customImages.append(customImage)
			self.images.append(UIImage(systemName: "photo"))
			promise(.success(()))
		}
		.eraseToAnyPublisher()
	}
	
	func delete(customImage: CustomImage) -> AnyPublisher<Void, Error> {
		if let index = customImages.firstIndex(where: { $0.id == customImage.id }) {
			customImages.remove(at: index)
			images.remove(at: index)
		}
		return Just(())
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
}
