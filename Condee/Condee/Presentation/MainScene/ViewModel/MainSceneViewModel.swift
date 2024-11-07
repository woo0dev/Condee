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
	@Published var isAddButtonTapped: Bool = false
	@Published var isLongPressGesture: Bool = false
	@Published var numberOfColumns: Int = 2
	
	private let fetchAllCustomImagesUseCase: FetchAllCustomImagesUseCase
	private let deleteCustomImageUseCase: DeleteCustomImageUseCase
	private var cancellables = Set<AnyCancellable>()
	
	init(fetchIAllCustomImagesUseCase: FetchAllCustomImagesUseCase, deleteCustomImageUseCase: DeleteCustomImageUseCase) {
		self.fetchAllCustomImagesUseCase = fetchIAllCustomImagesUseCase
		self.deleteCustomImageUseCase = deleteCustomImageUseCase
	}
	
	func fetchAll() {
		fetchAllCustomImagesUseCase.execute()
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("Failed to fetch all custom images: \(error)")
				}
			}, receiveValue: { [weak self] images in
				self?.customImages = images
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
		isAddButtonTapped = true
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
