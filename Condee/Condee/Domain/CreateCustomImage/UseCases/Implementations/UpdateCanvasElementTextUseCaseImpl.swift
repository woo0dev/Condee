//
//  UpdateCanvasElementTextUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 11/21/24.
//

final class UpdateCanvasElementTextUseCaseImpl: UpdateCanvasElementTextUseCase {
	func execute(element: CanvasElement, newText: String) -> CanvasElement {
		var updatedElement = element
		switch updatedElement.type {
		case .directInputText(_):
			updatedElement.type = .directInputText(newText)
		default:
			break
		}
		return updatedElement
	}
}
