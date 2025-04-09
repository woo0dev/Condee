//
//  MainSceneViewModel.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class MainSceneViewModel: ObservableObject {
	@Published var customImages: [CustomImage] = []
	@Published var images: [UIImage?] = []
	@Published var isNavigationActive: Bool = false
	@Published var isCreateViewPresented: Bool = false
	@Published var numberOfColumns: Int
	@Published var lastPinchThreshold: CGFloat = 1
	@Published var isPinchActive: Bool = false
	
	private let fetchAllCustomImagesUseCase: FetchAllCustomImagesUseCase
	private let deleteCustomImageUseCase: DeleteCustomImageUseCase
	private let imageLoaderUseCase: ImageLoaderUseCase
	private let numberOfColumnsUseCase: NumberOfColumnsUseCase
	private var cancellables = Set<AnyCancellable>()
	
	let customImageRepository: CustomImageRepository
	
	init(fetchAllCustomImagesUseCase: FetchAllCustomImagesUseCase, deleteCustomImageUseCase: DeleteCustomImageUseCase, imageLoaderUseCase: ImageLoaderUseCase, numberOfColumnsUseCase: NumberOfColumnsUseCase, customImageRepository: CustomImageRepository) {
		self.fetchAllCustomImagesUseCase = fetchAllCustomImagesUseCase
		self.deleteCustomImageUseCase = deleteCustomImageUseCase
		self.imageLoaderUseCase = imageLoaderUseCase
		self.numberOfColumnsUseCase = numberOfColumnsUseCase
		self.customImageRepository = customImageRepository
		
		self.numberOfColumns = numberOfColumnsUseCase.getNumberOfColumns()
	}
	
	func fetchAll() {
		fetchAllCustomImagesUseCase.execute()
			.flatMap { filteredCustomImages in
				self.imageLoaderUseCase.execute(from: filteredCustomImages)
					.map { uiImages in
						return (filteredCustomImages, uiImages)
					}
			}
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("Failed to fetch images: \(error.localizedDescription)")
				}
			}, receiveValue: { [weak self] filteredCustomImages, uiImages in
				self?.customImages = filteredCustomImages
				self?.images = uiImages
			})
			.store(in: &cancellables)
	}
	
	func deleteCustomImage(_ customImage: CustomImage) {
		deleteCustomImageUseCase.execute(customImage: customImage)
			.sink(receiveCompletion: { completion in
				switch completion {
					case .finished:
					break
				case .failure(let error):
					print("Failed to delete custom image: \(error)")
				}
			}, receiveValue: { [weak self] _ in
				self?.fetchAll()
			})
			.store(in: &cancellables)
	}
	
	func didSelectAddButton() {
		isCreateViewPresented = true
	}
	
	func startNavigation() {
		isNavigationActive = true
	}

	func endNavigation() {
		isNavigationActive = false
	}
	
	func handlePinchGesture(increase: Bool, value: CGFloat) {
		if increase {
			numberOfColumns = min(5, numberOfColumns + 1)
		} else {
			numberOfColumns = max(2, numberOfColumns - 1)
		}
		lastPinchThreshold = value
	}
	
	func startPinchGesture() {
		isPinchActive = true
	}

	func endPinchGesture() {
		isPinchActive = false
	}
	
	func updateNumberOfColumns() {
		numberOfColumnsUseCase.updateNumberOfColumns(newNumberOfColumns: numberOfColumns)
	}
}
