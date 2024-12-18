//
//  TextExtractorView.swift
//  Condee
//
//  Created by woo0 on 12/15/24.
//

import SwiftUI

struct TextExtractorView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@Binding var isExtractImageModalPresented: Bool
	
	var body: some View {
		ZStack {
			Color(.systemBackground)
				.ignoresSafeArea()
			VStack {
				HStack {
					Button(action: {
						isExtractImageModalPresented = false
					}, label: {
						Text("취소")
					})
					Spacer()
					Button(action: {
						print("완료")
					}, label: {
						Text("완료")
					})
				}
				.padding(20)
				Spacer()
				if let image = viewModel.extractImage {
					image
						.resizable()
						.scaledToFit()
				}
				Spacer()
			}
		}
	}
}
