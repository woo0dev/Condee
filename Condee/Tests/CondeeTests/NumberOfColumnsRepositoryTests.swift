//
//  NumberOfColumnsRepositoryTests.swift
//  CondeeTests
//
//  Created by woo0 on 3/19/25.
//

import Foundation
import Testing
@testable import Condee

struct NumberOfColumnsRepositoryTests {
	private var repository: NumberOfColumnsRepository!
	private var testSuiteName: String!
	
	mutating func setUp() async throws {
		testSuiteName = "TestSuite_NumberOfColumns_\(UUID().uuidString)"
		let testDefaults = UserDefaults(suiteName: testSuiteName)!
		testDefaults.removePersistentDomain(forName: testSuiteName)
		repository = NumberOfColumnsRepositoryImpl(userDefaults: testDefaults)
	}
	
	mutating func tearDown() async throws {
		if let suiteName = testSuiteName {
			UserDefaults.standard.removePersistentDomain(forName: suiteName)
		}
		repository = nil
	}
	
	@Test
	mutating func testDefaultNumberOfColumns() async throws {
		do {
			try await setUp()
			let defaultValue = repository.load()
			#expect(defaultValue == 3, "저장된 값이 없으면 기본값 3이어야 합니다.")
			try await tearDown()
		} catch {
			print("testDefaultNumberOfColumns error: \(error.localizedDescription)")
			return
		}
	}
	
	@Test
	mutating func testSaveAndLoadNumberOfColumns() async throws {
		do {
			try await setUp()
			repository.save(numberOfColumns: 4)
			let loadedValue = repository.load()
			#expect(loadedValue == 4, "저장한 값이 4여야 합니다.")
			try await tearDown()
		} catch {
			print("testSaveAndLoadNumberOfColumns error: \(error.localizedDescription)")
			return
		}
	}
	
	@Test
	mutating func testMultipleUpdates() async throws {
		do {
			try await setUp()
			repository.save(numberOfColumns: 5)
			#expect(repository.load() == 5, "값이 5로 업데이트되어야 합니다.")
			repository.save(numberOfColumns: 2)
			#expect(repository.load() == 2, "값이 2로 업데이트되어야 합니다.")
			try await tearDown()
		} catch {
			print("testMulipleUpdate error: \(error.localizedDescription)")
			return
		}
	}
}
