//
//  CreateCustomImageSceneView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI
import PhotosUI

struct CreateCustomImageSceneView: View {
	@StateObject var viewModel: CreateCustomImageSceneViewModel = DependencyContainer.shared.makeCreateCustomImageSceneViewModel()
	
	var body: some View {
		VStack() {
			GeometryReader { geometry in
				let width: CGFloat = min((geometry.size.width - 40), geometry.size.width)
				let height: CGFloat = min((width / 9) * 19.5, geometry.size.height)
				let centerX: CGFloat = geometry.size.width / 2
				let centerY: CGFloat = geometry.size.height / 2
				if width > 0 && height > 0 {
					CanvasView(viewModel: viewModel)
						.frame(width: width, height: height)
						.offset(x: centerX - width / 2, y: centerY - height / 2)
				}
			}
			AdditionalButtonsView(viewModel: viewModel)
		}
		.padding(20)
		.actionSheet(isPresented: $viewModel.isActionSheetPresented) {
			switch viewModel.actionSheetType {
			case .image:
				return showAddImage()
			case .text:
				return showAddText()
			default:
				return ActionSheet(title: Text("Error"))
			}
		}
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
	
	func showAddText() -> ActionSheet {
		let extractImageOption: ActionSheet.Button = .default(
			Text("이미지에서 추출하기").accessibilityLabel("ExtractImageOption")
		) {
			
		}
		let directInputOption: ActionSheet.Button = .default(
			Text("직접 입력하기").accessibilityLabel("DirectInputOption")
		) {
			viewModel.didSelectDirectInputOption()
		}
		let cancelOption: ActionSheet.Button = .cancel(Text("취소").accessibilityLabel("CancelOption"))
		
		let title = Text("추가할 텍스트 선택")
		
		return ActionSheet(title: title,
						   message: nil,
						   buttons: [extractImageOption, directInputOption, cancelOption])
	}
}

#Preview {
	CreateCustomImageSceneView()
}
