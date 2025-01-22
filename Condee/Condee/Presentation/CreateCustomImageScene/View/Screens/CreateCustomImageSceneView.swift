//
//  CreateCustomImageSceneView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI
import PhotosUI

struct CreateCustomImageSceneView: View {
	@StateObject var viewModel: CreateCustomImageSceneViewModel
	
	@Binding var navigationPath: NavigationPath
	
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
				ScrollView(.horizontal, showsIndicators: false) {
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
		.navigationBarItems(trailing: Button(action: {
			viewModel.doneTapped()
		}, label: {
			Text("미리보기")
		}).accessibilityIdentifier("PreviewButton"))
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
			TextExtractorView(viewModel: DependencyContainer.shared.makeTextExtractorViewModel(viewModel: viewModel))
		})
		.navigationDestination(for: UIImage.self, destination: { image in
			if let previewImage = viewModel.previewImage {
				CreateImageResultView(viewModel: viewModel, navigationPath: $navigationPath, previewImage: previewImage)
					.onDisappear() {
						viewModel.dismissCreateCustomImageView()
					}
			}
		})
		.onChange(of: viewModel.isDetailCustomImageViewPresented, {
			if let image = viewModel.previewUIImage, viewModel.isDetailCustomImageViewPresented {
				navigationPath.append(image)
			}
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
		let pasteImageOption: ActionSheet.Button = .default(
			Text("복사한 이미지 추가하기")
		) {
			viewModel.didSelectPasteImageOption()
		}
		let cancelOption: ActionSheet.Button = .cancel(Text("취소"))
		
		let title = Text("추가할 사진 선택")
		
		return ActionSheet(title: title,
						   message: nil,
						   buttons: [backgroundImageOption, addImageOption, pasteImageOption, cancelOption])
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

//#Preview {
//	CreateCustomImageSceneView()
//}
