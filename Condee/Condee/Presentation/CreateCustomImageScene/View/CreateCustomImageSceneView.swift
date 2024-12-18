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
		GeometryReader { geometry in
			VStack {
				let containerSize = geometry.size
				let aspectRatio: CGFloat = UIScreen.main.bounds.width / UIScreen.main.bounds.height
				
				let toolbarHeight: CGFloat = 50
				
				let canvasHeight: CGFloat = containerSize.height - toolbarHeight
				let canvasWidth: CGFloat = canvasHeight * aspectRatio
				
				if canvasWidth > 0 && canvasHeight > 0 {
					CanvasView(viewModel: viewModel)
						.frame(width: canvasWidth, height: canvasHeight)
						.border(.gray, width: 1)
						.clipped()
				}
				ScrollView(.horizontal) {
					HStack {
						AdditionalToolbar(viewModel: viewModel)
						TextStyleToolbar(viewModel: viewModel)
					}
					.frame(height: toolbarHeight)
					.padding([.leading, .trailing], 20)
				}
				.overlay(
					Rectangle()
						.frame(height: 1)
						.foregroundColor(.gray),
					alignment: .top
				)
			}
		}
		.ignoresSafeArea(.keyboard)
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
		.sheet(isPresented: $viewModel.isStickerHalfModalPresented, content: {
			StickersView(viewModel: viewModel)
				.cornerRadius(20)
				.presentationDetents([.height(300)])
		})
		.sheet(isPresented: $viewModel.isExtractImageModalPresented, content: {
			TextExtractorView(viewModel: viewModel, isExtractImageModalPresented: $viewModel.isExtractImageModalPresented)
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
			Text("배경 사진 선택하기")
		) {
			viewModel.didSelectBackgroundImageOption()
		}
		let addImageOption: ActionSheet.Button = .default(
			Text("사진 추가하기")
		) {
			viewModel.didSelectAddImageOption()
		}
		let cancelOption: ActionSheet.Button = .cancel(Text("취소"))
		
		let title = Text("추가할 사진 선택")
		
		return ActionSheet(title: title,
						   message: nil,
						   buttons: [backgroundImageOption, addImageOption, cancelOption])
	}
	
	func showAddText() -> ActionSheet {
		let extractImageOption: ActionSheet.Button = .default(
			Text("이미지에서 추출하기")
		) {
			viewModel.didSelectExtractImageOption()
		}
		let directInputOption: ActionSheet.Button = .default(
			Text("직접 입력하기")
		) {
			viewModel.didSelectDirectInputOption()
		}
		let cancelOption: ActionSheet.Button = .cancel(Text("취소"))
		
		let title = Text("추가할 텍스트 선택")
		
		return ActionSheet(title: title,
						   message: nil,
						   buttons: [extractImageOption, directInputOption, cancelOption])
	}
}

#Preview {
	CreateCustomImageSceneView()
}
