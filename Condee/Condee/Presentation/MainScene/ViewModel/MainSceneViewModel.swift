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
	
	private let fetchAllCustomImagesUseCase: FetchAllCustomImagesUseCase
	private let createCustomImageUseCase: CreateCustomImageUseCase
	private let deleteCustomImageUseCase: DeleteCustomImageUseCase
	private var cancellables = Set<AnyCancellable>()
	
	init(fetchIAllCustomImagesUseCase: FetchAllCustomImagesUseCase, createCustomImageUseCase: CreateCustomImageUseCase, deleteCustomImageUseCase: DeleteCustomImageUseCase) {
		self.fetchAllCustomImagesUseCase = fetchIAllCustomImagesUseCase
		self.createCustomImageUseCase = createCustomImageUseCase
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
	
	func addCustomImage(with url: URL) {
		createCustomImageUseCase.execute(imageURL: url)
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("Failed to create Custom Image: \(error)")
				}
			}, receiveValue: { [weak self] _ in
				self?.fetchAll()
			})
			.store(in: &cancellables)
	}
	
	func deleteCustomImage(_ image: CustomImage) {
		deleteCustomImageUseCase.execute(customImage: image)
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("Failed to create Custom Image: \(error)")
				}
			}, receiveValue: { [weak self] _ in
				self?.fetchAll()
			})
			.store(in: &cancellables)
	}
}
