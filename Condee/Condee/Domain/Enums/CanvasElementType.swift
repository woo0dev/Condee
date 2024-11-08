//
//  CanvasElementType.swift
//  Condee
//
//  Created by woo0 on 11/8/24.
//

import SwiftUI

enum CanvasElementType {
	case additionalImage(Image)
	case emoji(Image)
	case extractImage(Image)
	case directInputText(String, Color)
}
