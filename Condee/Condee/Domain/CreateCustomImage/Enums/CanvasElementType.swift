//
//  CanvasElementType.swift
//  Condee
//
//  Created by woo0 on 11/8/24.
//

import SwiftUI

enum CanvasElementType {
	case additionalImage(Image)
	case sticker(Image)
	case extractImage(Image)
	case directInputText(String)
}

extension CanvasElementType {
	var isTextElement: Bool {
		if case .directInputText = self {
			return true
		}
		return false
	}
}
