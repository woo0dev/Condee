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
		let customImageRepository = CustomImageRepositoryImpl(modelContext: modelContext)
		let imageRepository = ImageRepositoryImpl()
		
		let fetchUseCase = FetchAllCustomImagesUseCaseImpl(repository: customImageRepository)
		let deleteUseCase = DeleteCustomImageUseCaseImpl(repository: customImageRepository)
		let imageLoaderUseCase = ImageLoaderUseCaseImpl(repository: imageRepository)
		
		return MainSceneViewModel(fetchAllCustomImagesUseCase: fetchUseCase, deleteCustomImageUseCase: deleteUseCase, imageLoaderUseCase: imageLoaderUseCase, customImageRepository: customImageRepository)
	}
	
	@MainActor
	func makeCreateCustomImageSceneViewModel(repository: CustomImageRepository) -> CreateCustomImageSceneViewModel {
		let createCustomImageUseCase = CreateCustomImageUseCaseImpl(repository: repository)
		let cropImageUseCase = CropImageUseCaseImpl()
		let imageFixingUseCase = ImageFixingUseCaseImpl()
		let updateCanvasElementTextUseCase = UpdateCanvasElementTextUseCaseImpl()
		return CreateCustomImageSceneViewModel(createCustomImageUseCase: createCustomImageUseCase, cropImageUseCase: cropImageUseCase, imageFixingUseCase: imageFixingUseCase, updateTextUseCase: updateCanvasElementTextUseCase)
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
