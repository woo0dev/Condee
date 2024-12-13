//
//  StickersView.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct StickersView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var stickers: [Image] = [Image("mouse"), Image("cow"), Image("tiger"), Image("rabbit"), Image("dragon"), Image("snake"), Image("horse"), Image("sheep"), Image("monkey"), Image("chicken"), Image("dog"), Image("pig")]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
				ForEach(stickers.indices, id: \.self) { index in
					Button(action: {
						viewModel.didSelectSticker(stickerImage: stickers[index])
					}, label: {
						stickers[index]
							.resizable()
							.scaledToFit()
							.frame(width: 50, height: 50)
							.padding(20)
							.background(Color(UIColor.lightGray))
							.cornerRadius(20)
					})
				}
			}
			.accessibilityIdentifier("StickersGridView")
		}
		.padding([.top, .leading, .trailing], 20)
	}
}

#Preview {
	StickersView(viewModel: DependencyContainer.shared.makeCreateCustomImageSceneViewModel())
}
