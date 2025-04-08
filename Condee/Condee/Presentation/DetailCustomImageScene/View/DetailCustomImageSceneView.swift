//
//  DetailCustomImageSceneView.swift
//  Condee
//
//  Created by woo0 on 11/4/24.
//

import SwiftUI

struct DetailCustomImageSceneView: View {
	@Environment(\.dismiss) private var dismiss
	
	let customImage: CustomImage
	let previewImage: PreviewImage
	
	var body: some View {
		ZStack {
			BackGestureEnabler()
			VStack {
				AsyncImage(url: customImage.imageURL) { phase in
					switch phase {
					case .empty:
						ProgressView()
					case .success(let image):
						image
							.resizable()
							.scaledToFit()
							.accessibilityIdentifier("DetailCustomImage")
					case .failure(_):
						Image(systemName: "exclamationmark.triangle")
							.resizable()
							.scaledToFit()
					@unknown default:
						EmptyView()
					}
				}
			}
			.navigationBarBackButtonHidden(true)
			.toolbar(content: {
				ToolbarItem(placement: .topBarLeading, content: {
					BackButtonView() {
						dismiss()
					}
				})
				ToolbarItem(placement: .topBarTrailing, content: {
					ShareLink(
						item: previewImage,
						preview: SharePreview(previewImage.caption, image: previewImage.image)
					)
					.buttonStyle(.plain)
					.padding(.horizontal, 10)
				})
			})
		}
	}
}
