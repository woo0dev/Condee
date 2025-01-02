//
//  ResizeButton.swift
//  Condee
//
//  Created by woo0 on 1/2/25.
//

import SwiftUI

struct ResizeButton: View {
	@Binding var size: CGFloat
	
	let minSize: CGFloat
	let maxSize: CGFloat
	
	var body: some View {
		HStack(spacing: 0) {
			Button(action: {
				if size - 1 >= minSize {
					size -= 1
				}
			}, label: {
				Image(systemName: "minus")
					.font(.system(size: 24))
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			})
			.accessibilityIdentifier("IncreaseFontSizeButton")
			.frame(width: 40, height: 40)
			.foregroundStyle(.primary)
			Divider()
				.frame(width: 1, height: 30)
				.foregroundStyle(.primary)
			Button(action: {
				if size + 1 <= maxSize {
					size += 1
				}
			}, label: {
				Image(systemName: "plus")
					.font(.system(size: 24))
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			})
			.accessibilityIdentifier("DecreaseFontSizeButton")
			.frame(width: 40, height: 40)
			.foregroundStyle(.primary)
		}
		.frame(height: 40)
		.background(Color.gray)
		.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}
