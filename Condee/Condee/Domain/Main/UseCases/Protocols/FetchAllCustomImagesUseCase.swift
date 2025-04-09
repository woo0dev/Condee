//
//  FetchAllCustomImagesUseCase.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import Combine

protocol FetchAllCustomImagesUseCase {
	func execute() -> AnyPublisher<[CustomImage], Error>
}
