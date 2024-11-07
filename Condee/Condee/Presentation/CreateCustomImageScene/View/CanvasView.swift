//
//  CanvasView.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct	CanvasView: View {
	@ObservedObject var viewModel: CreateCustomImageSceneViewModel
	
	var body: some View {
		ZStack {
			GridPatternBackgroundView()
				.accessibilityIdentifier("GridPatternBackgroundView")
			if let backgroundImage = viewModel.selectedBackgroundImage {
				backgroundImage
					.resizable()
			}
		}
	}
}
