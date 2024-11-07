//
//  DetailCustomImageSceneView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI

struct DetailCustomImageSceneView: View {
	var customImage: CustomImage
	
	var body: some View {
		AsyncImage(url: customImage.imageURL) { phase in
			switch phase {
			case .empty:
				ProgressView()
			case .success(let image):
				image
					.resizable()
					.scaledToFit()
			case .failure(let error):
				Image(systemName: "exclamationmark.triangle")
					.resizable()
					.scaledToFit()
			@unknown default:
				EmptyView()
			}
		}
	}
}
