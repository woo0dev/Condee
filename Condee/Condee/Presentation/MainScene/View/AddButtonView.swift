//
//  AddButtonView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI

struct AddButtonView: View {
	@ObservedObject var viewModel: MainSceneViewModel
	
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				Button(action: {
					viewModel.didSelectAddButton()
				}, label: {
					Label("새로 만들기", systemImage: "plus")
						.font(.title3)
						.padding()
						.background(Color.white)
						.foregroundColor(.black)
						.cornerRadius(20)
				})
				.padding(20)
				.accessibilityIdentifier("addButton")
			}
		}
	}
}
