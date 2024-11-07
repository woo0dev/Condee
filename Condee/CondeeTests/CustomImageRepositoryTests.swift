//
//  CustomImageRepositoryTests.swift
//  CondeeTests
//
//  Created by woo0 on 11/2/24.
//

import Foundation
import SwiftData
import Testing
@testable import Condee

struct CustomImageRepositoryTests {
	private var modelContainer: ModelContainer!
	
	mutating func setUp() async throws {
		modelContainer = try ModelContainer(for: CustomImage.self, configurations: .init())
	}
	
	mutating func tearDown() async throws {
		modelContainer = nil
	}
	
	@Test
	mutating func testCreateAndDeleteCustomImage() async throws {
		do {
			try await setUp()
			
			let context = ModelContext(modelContainer)
			let imageURL = URL(string: "https://picsum.photos/1179/2556")!
			
			let customImage = CustomImage(imageURL: imageURL)
			
			context.insert(customImage)
			try context.save()
			
			let fetchedImagesAfterCreate = try context.fetch(FetchDescriptor<CustomImage>())
			
			#expect(fetchedImagesAfterCreate.count > 0, "CustomImage가 저장에 실패했습니다.")
			
			context.delete(customImage)
			try context.save()
			
			let fetchedImagesAfterDelete = try context.fetch(FetchDescriptor<CustomImage>())
			
			#expect(fetchedImagesAfterDelete.isEmpty, "CustomImage가 삭제에 실패했습니다.")
			
			try await tearDown()
		} catch {
			print("testCreateAndDeleteCustomImage error: \(error.localizedDescription)")
			return
		}
	}
}
