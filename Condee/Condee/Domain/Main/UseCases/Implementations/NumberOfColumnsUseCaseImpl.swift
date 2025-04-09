//
//  NumberOfColumnsUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 3/19/25.
//

import Foundation

final class NumberOfColumnsUseCaseImpl: NumberOfColumnsUseCase {
	private let repository: NumberOfColumnsRepository
	
	init(repository: NumberOfColumnsRepository) {
		self.repository = repository
	}
	
	func getNumberOfColumns() -> Int {
		return repository.load()
	}
	
	func updateNumberOfColumns(newNumberOfColumns: Int) {
		repository.save(numberOfColumns: newNumberOfColumns)
	}
}
