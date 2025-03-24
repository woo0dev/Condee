//
//  NumberOfColumnsRepository.swift
//  Condee
//
//  Created by woo0 on 3/19/25.
//

import Foundation

protocol NumberOfColumnsRepository {
	func save(numberOfColumns: Int)
	func load() -> Int
}
