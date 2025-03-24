//
//  NumberOfColumnsRepositoryImpl.swift
//  Condee
//
//  Created by woo0 on 3/19/25.
//

import Foundation

class NumberOfColumnsRepositoryImpl: NumberOfColumnsRepository {
	private let key = "numberOfColumns"
	private let userDefaults: UserDefaults
	
	init(userDefaults: UserDefaults = .standard) {
		self.userDefaults = userDefaults
	}

	func save(numberOfColumns: Int) {
		userDefaults.set(numberOfColumns, forKey: key)
	}

	func load() -> Int {
		userDefaults.object(forKey: key) as? Int ?? 3
	}
}
