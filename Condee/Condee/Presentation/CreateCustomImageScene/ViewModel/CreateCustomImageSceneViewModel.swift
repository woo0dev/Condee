//
//  CreateCustomImageSceneViewModel.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import Combine
import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class CreateCustomImageSceneViewModel: ObservableObject {
	@Published var selectedPhotosItems: [PhotosPickerItem] = []
	@Published var imageSource: ImageSource = .backgroundImage
	@Published var selectedBackgroundImage: Image? = nil
	@Published var addedImages: [Image] = []
	@Published var addedEmojis: [Image] = []
	@Published var addedExtractTests: [Image] = []
	@Published var addedDirectInputTests: [String] = []
	@Published var selectedColor: Color = .black
	@Published var isPhotosPickerPresented: Bool = false
	@Published var isPhotoActionSheetPresented: Bool = false
	@Published var isEmojiHalfModalPresented: Bool = false
	@Published var isTextActionSheetPresented: Bool = false
	@Published var isColorPickerPresented: Bool = false
	
	func didSelectAddPhotoButton() {
		isPhotoActionSheetPresented = true
	}
	
	func didSelectBackgroundImageOption() {
		imageSource = .backgroundImage
		isPhotosPickerPresented = true
	}
	
	func didSelectAddImageOption() {
		imageSource = .additionalImage
		isPhotosPickerPresented = true
	}
	
	func didSelectAddEmojiButton() {
		isEmojiHalfModalPresented = true
	}
	
	func didSelectEmoji(emoji: Image) {
		addedEmojis.append(emoji)
		print(addedEmojis)
	}
	
	func didSelectAddTextButton() {
		isTextActionSheetPresented = true
	}
	
	func convertPhotosPickerItemsToImage() {
		if let item = selectedPhotosItems.first {
			item.loadTransferable(type: Data.self) { loadingResult in
				switch loadingResult {
				case .success(let data):
					if let data = data,
					   let uiImage = UIImage(data: data) {
						Task { @MainActor in
							switch self.imageSource {
							case .backgroundImage:
								self.selectedBackgroundImage = Image(uiImage: uiImage)
							case .additionalImage:
								self.addedImages.append(Image(uiImage: uiImage))
							case .extractImage:
								self.addedExtractTests.append(Image(uiImage: uiImage))
							}
						}
					}
				case .failure(let error):
					print("Failed to load photo: \(error)")
				}
			}
		}
	}
}
