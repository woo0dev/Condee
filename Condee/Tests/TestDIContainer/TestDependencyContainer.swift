//
//  TestDependencyContainer.swift
//  CondeeTests
//
//  Created by woo0 on 3/27/25.
//

import SwiftUI

@testable import Condee

final class TestDependencyContainer {
	@MainActor
	func makeMainSceneViewModelWithMocks() -> MainSceneViewModel {
		let customImageRepository = MockCustomImageRepositoryImpl()
		let imageRepository = ImageRepositoryImpl()
		let numberOfColumnsRepository = NumberOfColumnsRepositoryImpl()
		
		let fetchUseCase = MockFetchAllCustomImagesUseCaseImpl(repository: customImageRepository)
		let deleteUseCase = MockDeleteCustomImageUseCaseImpl(repository: customImageRepository)
		let imageLoaderUseCase = ImageLoaderUseCaseImpl(repository: imageRepository)
		let numberOfColumnsUseCase = NumberOfColumnsUseCaseImpl(repository: numberOfColumnsRepository)
		
		return MainSceneViewModel(fetchAllCustomImagesUseCase: fetchUseCase, deleteCustomImageUseCase: deleteUseCase, imageLoaderUseCase: imageLoaderUseCase, numberOfColumnsUseCase: numberOfColumnsUseCase, customImageRepository: customImageRepository)
	}
}
