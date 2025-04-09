//
//  CreateCustomImageUseCase.swift
//  Condee
//
//  Created by woo0 on 11/3/24.
//

import Combine
import Foundation

protocol CreateCustomImageUseCase {
	func execute(customImage: CustomImage) -> AnyPublisher<Void, Error>
}
