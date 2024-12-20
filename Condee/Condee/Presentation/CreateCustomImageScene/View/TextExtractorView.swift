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
					Spacer()
					Button(action: {
						viewModel.doneTapped()
					}, label: {
						Text("완료")
							.padding(20)
					})
				}
				.overlay(
					Rectangle()
						.frame(height: 1)
						.foregroundColor(.primary)
					, alignment: .bottom
				)
				Spacer()
				if let image = viewModel.getTextExtractionImage() {
					if let extractedImage = viewModel.selectedExtractedImage {
						ZStack {
							GridPatternBackgroundView()
							Image(uiImage: extractedImage)
								.resizable()
								.scaledToFit()
						}
					} else {
						ImageCropView(cropRect: $viewModel.cropRect, imageRect: $viewModel.imageRect, image: image)
						Button(action: {
							viewModel.extractTapped()
						}, label: {
							Text("배경 제거하기")
								.font(.title3)
								.padding()
						})
						.foregroundColor(Color(.systemBackground))
						.background(.primary)
						.cornerRadius(20)
						.padding(.bottom)
					}
				}
				Spacer()
			}
		}
	}
}
