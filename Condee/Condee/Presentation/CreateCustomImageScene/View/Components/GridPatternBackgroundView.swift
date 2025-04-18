//
//  GridPatternBackgroundView.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct GridPatternBackgroundView: View {
	@Binding var color: Color
	
	var body: some View {
		GeometryReader { geometry in
			let squareSize: CGFloat = 10
			let columns: Int = Int(ceil(geometry.size.width / squareSize))
			let rows: Int = Int(ceil(geometry.size.height / squareSize))
			
			ForEach(0..<rows, id: \.self) { row in
				ForEach(0..<columns, id: \.self) { column in
					Rectangle()
						.fill((row + column).isMultiple(of: 2) ? Color(UIColor.lightGray) : color)
						.frame(width: squareSize, height: squareSize)
						.position(
							x: CGFloat(column) * squareSize + squareSize / 2,
							y: CGFloat(row) * squareSize + squareSize / 2
						)
				}
			}
		}
	}
}

//#Preview {
//	GridPatternBackgroundView()
//}
