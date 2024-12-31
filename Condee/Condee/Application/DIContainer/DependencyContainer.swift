//
//  DependencyContainer.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI
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
		let adjustcontrastUseCase = AdjustContrastUseCaseImpl()
		let cropImageUseCase = CropImageUseCaseImpl()
		let extractTextUseCase = ExtractTextUseCaseImpl()
		let imageResizingUseCase = ImageResizingUseCaseImpl()
		let eraseImageUseCase = EraseImageUseCaseImpl()
		
		return TextExtractorViewModel(
			createCustomImageSceneViewModel: viewModel,
			adjustContrastUseCase: adjustcontrastUseCase,
			cropImageUseCase: cropImageUseCase,
			extractTextUseCase: extractTextUseCase,
			imageResizingUseCase: imageResizingUseCase,
			eraseImageUseCase: eraseImageUseCase
		)
	}
}
