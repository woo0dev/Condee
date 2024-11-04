//
//  FetchAllCustomImageUseCase.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import Combine

protocol FetchAllCustomImageUseCase {
	func execute() -> AnyPublisher<[CustomImage], Error>
}
