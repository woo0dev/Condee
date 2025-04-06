//
//  NumberOfColumnsUseCase.swift
//  Condee
//
//  Created by woo0 on 3/19/25.
//

import Foundation

protocol NumberOfColumnsUseCase {
	func getNumberOfColumns() -> Int
	
	func updateNumberOfColumns(newNumberOfColumns: Int)
}
