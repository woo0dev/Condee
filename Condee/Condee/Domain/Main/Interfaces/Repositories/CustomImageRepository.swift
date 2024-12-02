//
//  CustomImageRepository.swift
//  Condee
//
//  Created by woo0 on 11/3/24.
//

import Combine

protocol CustomImageRepository {
	func fetchAll() -> AnyPublisher<[CustomImage], Error>
	func create(customImage: CustomImage) -> AnyPublisher<Void, Error>
	func delete(customImage: CustomImage) -> AnyPublisher<Void, Error>
}
