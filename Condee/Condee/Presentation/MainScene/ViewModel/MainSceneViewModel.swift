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
	private var cancellables = Set<AnyCancellable>()
	
	init(fetchIAllCustomImagesUseCase: FetchAllCustomImagesUseCase) {
		self.fetchAllCustomImagesUseCase = fetchIAllCustomImagesUseCase
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
}
