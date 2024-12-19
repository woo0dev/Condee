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
		let fetchUseCase = FetchAllCustomImagesUseCaseImpl(repository: repository)
		let deleteUseCase = DeleteCustomImageUseCaseImpl(repository: repository)
		return MainSceneViewModel(fetchAllCustomImagesUseCase: fetchUseCase, deleteCustomImageUseCase: deleteUseCase)
	}
	
	@MainActor
	func makeCreateCustomImageSceneViewModel() -> CreateCustomImageSceneViewModel {
		let updateCanvasElementTextUseCase = UpdateCanvasElementTextUseCaseImpl()
		return CreateCustomImageSceneViewModel(updateTextUseCase: updateCanvasElementTextUseCase)
	}
	
	@MainActor
	func makeTextExtractorViewModel(viewModel: CreateCustomImageSceneViewModel) -> TextExtractorViewModel {
		let cropImageUseCase = CropImageUseCaseImpl()
		
		return TextExtractorViewModel(
			addedCanvasElements: viewModel.addedCanvasElements,
			currentEditingCanvasElement: viewModel.currentEditingCanvasElement,
			extractUIImage: viewModel.extractUIImage,
			cropImageUseCase: cropImageUseCase
		)
	}
}
