//
//  UpdateCanvasElementTextUseCase.swift
//  Condee
//
//  Created by woo0 on 11/21/24.
//

protocol UpdateCanvasElementTextUseCase {
	func execute(element: CanvasElement, newText: String) -> CanvasElement
}
