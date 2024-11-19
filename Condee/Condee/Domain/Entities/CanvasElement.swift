//
//  CanvasElement.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct CanvasElement: Identifiable, Hashable, Equatable {
	let id: UUID = UUID()
	var type: CanvasElementType
	var size: CGSize = .zero
	var offset: CGSize = .zero
	var rotation: Angle = .zero
	
	var image: Image? {
		switch type {
		case .additionalImage(let img), .emoji(let img), .extractImage(let img):
			return img
		default:
			return nil
		}
	}
	
	var text: String? {
		if case .directInputText(let content, _) = type {
			return content
		}
		return nil
	}
	
	var color: Color? {
		if case .directInputText(_, let col) = type {
			return col
		}
		return nil
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	static func == (lhs: CanvasElement, rhs: CanvasElement) -> Bool {
		lhs.id == rhs.id
	}
}
