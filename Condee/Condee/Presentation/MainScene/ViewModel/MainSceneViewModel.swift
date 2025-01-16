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
	@Published var isCreateViewPresented: Bool = false
	@Published var isLongPressGesture: Bool = false
	@Published var numberOfColumns: Int = 2
	
	private let fetchAllCustomImagesUseCase: FetchAllCustomImagesUseCase
	private let deleteCustomImageUseCase: DeleteCustomImageUseCase
	private let imageLoaderUseCase: ImageLoaderUseCase
	private var cancellables = Set<AnyCancellable>()
	
	let customImageRepository: CustomImageRepository
	
	init(fetchAllCustomImagesUseCase: FetchAllCustomImagesUseCase, deleteCustomImageUseCase: DeleteCustomImageUseCase, imageLoaderUseCase: ImageLoaderUseCase, customImageRepository: CustomImageRepository) {
		self.fetchAllCustomImagesUseCase = fetchAllCustomImagesUseCase
		self.deleteCustomImageUseCase = deleteCustomImageUseCase
		self.imageLoaderUseCase = imageLoaderUseCase
		self.customImageRepository = customImageRepository
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
	
	func didLongPressGesture() {
		isLongPressGesture = true
	}
	
	func handlePinchGesture(with value: CGFloat) {
		if value > 1.2 && numberOfColumns == 3 {
			numberOfColumns = 2
		} else if value < 0.8 && numberOfColumns == 2 {
			numberOfColumns = 3
		}
	}
}
