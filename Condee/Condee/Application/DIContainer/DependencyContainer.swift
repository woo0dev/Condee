//
//  DependencyContainer.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import Foundation
import SwiftData

final class DependencyContainer {
	static let shared = DependencyContainer()
	
	@MainActor
	func makeMainSceneViewModel(modelContainer: ModelContainer) -> MainSceneViewModel {
		let modelContext = ModelContext(modelContainer)
		let repository = CustomImageRepositoryImpl(modelContext: modelContext)
		let useCase = FetchAllCustomImagesUseCaseImpl(repository: repository)
		return MainSceneViewModel(fetchIAllCustomImagesUseCase: useCase)
	}
}
