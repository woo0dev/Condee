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
		let cropImageUseCase = CropImageUseCaseImpl()
		let imageFixingUseCase = ImageFixingUseCaseImpl()
		let updateCanvasElementTextUseCase = UpdateCanvasElementTextUseCaseImpl()
		return CreateCustomImageSceneViewModel(cropImageUseCase: cropImageUseCase, imageFixingUseCase: imageFixingUseCase, updateTextUseCase: updateCanvasElementTextUseCase)
	}
	
	@MainActor
	func makeTextExtractorViewModel(viewModel: CreateCustomImageSceneViewModel) -> TextExtractorViewModel {
		let adjustcontrastUseCase = AdjustContrastUseCaseImpl()
		let cropImageUseCase = CropImageUseCaseImpl()
		let extractTextUseCase = ExtractTextUseCaseImpl()
		let imageResizingUseCase = ImageResizingUseCaseImpl()
		let removeEmptySpaceUseCase = RemoveEmptySpaceUseCaseImpl()
		let eraseImageUseCase = EraseImageUseCaseImpl()
		
		return TextExtractorViewModel(
			createCustomImageSceneViewModel: viewModel,
			adjustContrastUseCase: adjustcontrastUseCase,
			cropImageUseCase: cropImageUseCase,
			extractTextUseCase: extractTextUseCase,
			imageResizingUseCase: imageResizingUseCase,
			removeEmptySpaceUseCase: removeEmptySpaceUseCase,
			eraseImageUseCase: eraseImageUseCase
		)
	}
}
