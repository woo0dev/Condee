//
//  CreateImageResultView.swift
//  Condee
//
//  Created by woo0 on 1/13/25.
//

import SwiftUI

struct CreateImageResultView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	@Binding var navigationPath: NavigationPath
	
	let resultImage: UIImage
	
	var body: some View {
		VStack {
			Image(uiImage: resultImage)
				.resizable()
				.scaledToFit()
				.padding(20)
		}
		.navigationBarItems(trailing: Button(action: {
			viewModel.saveCreatedImage()
		}, label: {
			Text("저장")
		}))
		.onChange(of: viewModel.isSavingComplete, {
			if viewModel.isSavingComplete {
				navigationPath = .init()
			}
		})
	}
}
