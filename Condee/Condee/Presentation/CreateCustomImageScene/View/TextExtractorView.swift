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
						viewModel.isExtractImageModalPresented = false
					}, label: {
						Text("취소")
							.padding(20)
					})
					Spacer()
					Button(action: {
						viewModel.cropImage()
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
				if let image = viewModel.extractUIImage {
					ImageCropView(cropRect: $viewModel.cropRect, image: image)
				}
				Spacer()
			}
		}
	}
}
