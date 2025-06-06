//
//  TextExtractorView.swift
//  Condee
//
//  Created by woo0 on 12/15/24.
//

import SwiftUI

struct TextExtractorView: View {
	@StateObject var viewModel: TextExtractorViewModel
	
	var body: some View {
		ZStack {
			Color(.systemBackground)
				.ignoresSafeArea()
			VStack {
				HStack {
					Button(action: {
						viewModel.cancleTapped()
					}, label: {
						Text("취소")
							.padding(20)
					})
					.accessibilityIdentifier("CancelButton")
					.buttonStyle(.plain)
					Spacer()
					Button(action: {
						viewModel.doneTapped()
					}, label: {
						Text("완료")
							.padding(20)
					})
					.accessibilityIdentifier("DoneButton")
					.buttonStyle(.plain)
				}
				.overlay(
					Rectangle()
						.frame(height: 1)
						.foregroundColor(.primary)
					, alignment: .bottom
				)
				Spacer()
				if let image = viewModel.extractImage, viewModel.isEditing == false {
					if viewModel.extractedImages.count > 0 {
						ScrollView(showsIndicators: false) {
							ForEach(viewModel.extractedImages, id: \.self) { extractedImage in
								ZStack {
									Image(uiImage: extractedImage)
										.resizable()
										.scaledToFit()
										.accessibilityIdentifier("ExtractedImage")
										.background(GridPatternBackgroundView(color: $viewModel.gridPatternColor))
								}
								.clipShape(RoundedRectangle(cornerRadius: 20))
								.overlay(
									RoundedRectangle(cornerRadius: 20)
										.stroke(viewModel.selectedExtractedImage == extractedImage ? Color.blue : Color.clear, lineWidth: 4)
								)
								.padding()
								.onTapGesture {
									viewModel.selectedExtractedImage = extractedImage
								}
							}
						}
						.transition(.opacity.animation(.easeIn))
						Button(action: {
							viewModel.editTapped()
						}, label: {
							Text("편집")
						})
						.buttonStyle(RoundedRectangleButtonStyle())
						.padding(.bottom)
					} else {
						ImageCropView(cropRect: $viewModel.cropRect, imageRect: $viewModel.imageRect, image: image)
							.accessibilityIdentifier("ExtractImageView")
							.transition(.opacity.animation(.easeOut))
						Text("tip: 여러가지 색상이 포함된 이미지는 배경제거가 되지 않을 수 있습니다.")
							.foregroundStyle(Color.gray)
							.multilineTextAlignment(.leading)
						Button(action: {
							viewModel.extractTapped()
						}, label: {
							Text("배경 제거하기")
						})
						.accessibilityIdentifier("ExtractButton")
						.buttonStyle(RoundedRectangleButtonStyle())
						.padding(.bottom)
					}
				} else if let selectedExtractedImage = viewModel.selectedExtractedImage {
					ErasableImageView(viewModel: viewModel, image: selectedExtractedImage)
						.transition(.opacity.animation(.easeIn))
				}
				Spacer()
			}
			if viewModel.isExtracting {
				SparklesAnimationView(size: viewModel.imageRect.size)
			}
		}
		.toast(isPresented: $viewModel.isToastPresented, message: viewModel.toastMessage)
	}
}
