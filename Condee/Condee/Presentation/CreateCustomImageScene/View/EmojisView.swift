//
//  EmojisView.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct EmojisView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var emojis: [Image] = [Image("mouse"), Image("cow"), Image("tiger"), Image("rabbit"), Image("dragon"), Image("snake"), Image("horse"), Image("sheep"), Image("monkey"), Image("chicken"), Image("dog"), Image("pig")]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
				ForEach(emojis.indices, id: \.self) { index in
					Button(action: {
						viewModel.didSelectEmoji(emojiImage: emojis[index])
					}, label: {
						emojis[index]
							.resizable()
							.scaledToFit()
							.frame(width: 50, height: 50)
							.padding(20)
							.background(Color(UIColor.lightGray))
							.cornerRadius(20)
					})
				}
			}
			.accessibilityIdentifier("EmojisGridView")
		}
		.padding([.top, .leading, .trailing], 20)
	}
}

#Preview {
	EmojisView(viewModel: DependencyContainer.shared.makeCreateCustomImageSceneViewModel())
}
