//
//  DeleteCustomImageUseCase.swift
//  Condee
//
//  Created by woo0 on 11/3/24.
//

import Combine

protocol DeleteCustomImageUseCase {
	func execute(customImage: CustomImage) -> AnyPublisher<Void, Error>
}
