//
//  CanvasElement.swift
//  Condee
//
//  Created by woo0 on 11/7/24.
//

import SwiftUI

struct CanvasElement: Identifiable {
	let id: UUID = UUID()
	var type: CanvasElementType
	var offset: CGSize = .zero
	var scale: CGFloat = 1.0
	var rotation: Angle = .zero
	
	var image: Image? {
		if case .additionalImage(let img) = type {
			return img
		} else if case .emoji(let img) = type {
			return img
		} else if case .extractImage(let img) = type {
			return img
		}
		return nil
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
}
