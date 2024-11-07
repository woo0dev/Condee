//
//  CreateCustomImageSceneView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI
import PhotosUI

struct CreateCustomImageSceneView: View {
	@StateObject var viewModel: CreateCustomImageSceneViewModel = CreateCustomImageSceneViewModel()
	
	var body: some View {
		VStack {
			GeometryReader { geometry in
				let width: CGFloat = (geometry.size.width - 40)
				let height: CGFloat = (width / 9) * 19.5
				let centerX = geometry.size.width / 2
				let centerY = geometry.size.height / 2
				if width > 0 && height > 0 {
					CanvasView(viewModel: viewModel)
					.frame(width: width, height: height)
					.position(x: centerX, y: centerY)
				}
			}
			.padding()
			AdditionalButtonsView(viewModel: viewModel)
		}
		.padding(20)
		.actionSheet(isPresented: $viewModel.isPhotoActionSheetPresented, content: showAddImage)
		.sheet(isPresented: $viewModel.isEmojiHalfModalPresented, content: {
			EmojisView(viewModel: viewModel)
				.cornerRadius(20)
				.presentationDetents([.height(300)])
		})
		.photosPicker(
			isPresented: $viewModel.isPhotosPickerPresented,
			selection: $viewModel.selectedPhotosItems,
			maxSelectionCount: 1,
			matching: .images
		)
		.onChange(of: viewModel.selectedPhotosItems, {
			viewModel.convertPhotosPickerItemsToImage()
		})
	}
	
	func showAddImage() -> ActionSheet {
		let backgroundImageOption: ActionSheet.Button = .default(
			Text("배경 사진 선택하기").accessibilityLabel("BackgroundImageOption")
		) {
			viewModel.didSelectBackgroundImageOption()
		}
		let addImageOption: ActionSheet.Button = .default(
			Text("사진 추가하기").accessibilityLabel("AddImageOption")
		) {
			viewModel.didSelectAddImageOption()
		}
		let cancelOption: ActionSheet.Button = .cancel(Text("취소").accessibilityLabel("CancelOption"))
		
		let title = Text("추가할 사진 선택")
		
		return ActionSheet(title: title,
						   message: nil,
						   buttons: [backgroundImageOption, addImageOption, cancelOption])
	}
}

#Preview {
	CreateCustomImageSceneView()
}
