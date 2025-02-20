//
//  MainSceneViewUITests.swift
//  CondeeUITests
//
//  Created by woo0 on 11/2/24.
//

import XCTest

@MainActor
final class MainSceneUITests: XCTestCase {
	private let app = XCUIApplication()
	
    override func setUpWithError() throws {
        continueAfterFailure = false
		app.launch()
    }
	
	func testElementsMainSceneView() throws {
		app.launch()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			let addButton = self.app.buttons["addButton"]
			XCTAssertTrue(addButton.exists, "새로 만들기 버튼이 없습니다.")
			
			let appNameLabel = self.app.staticTexts["Condee"]
			XCTAssertTrue(appNameLabel.exists, "앱 이름이 표시되지 않습니다.")
			
			for index in 0..<4 {
				let imageElement = self.app.images["image\(index)"]
				XCTAssertTrue(imageElement.exists, "이미지\(index)가 표시되지 않습니다.")
			}
		}
	}
	
    func testAddButtonOpensCreateCustomImageView() throws {
        app.launch()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			let addButton = self.app.buttons["addButton"]
			XCTAssertTrue(addButton.exists, "새로 만들기 버튼이 없습니다.")
			addButton.tap()
			
			let createCustomImageView = self.app.otherElements["CreateCustomImageView"]
			XCTAssertTrue(createCustomImageView.exists, "CreateCustomImageView를 불러올 수 없습니다.")
			
			self.app.buttons["backButton"].tap()
			XCTAssertFalse(createCustomImageView.exists, "뒤로가기 버튼을 클릭할 수 없습니다.")
		}
    }
	
	func testGestureCustomImagesView() throws {
		app.launch()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			let customImagesView = self.app.otherElements["CustomImagesView"]
			XCTAssertTrue(customImagesView.exists, "CustomImagesView가 존재하지 않습니다.")
			
			let initialSize = customImagesView.frame.size
			customImagesView.pinch(withScale: 1.5, velocity: 1.0)
			
			let resizedSize = customImagesView.frame.size
			XCTAssertNotEqual(resizedSize, initialSize, "CustomImagesView 크기가 변경되지 않았습니다.")
			
			let customImageView = self.app.images["CustomImageView"]
			XCTAssertTrue(customImageView.exists, "CustomImageView가 표시되지 않습니다.")
			
			customImageView.tap()
			
			let customImageDetailView = self.app.otherElements["CustomImageDetailView"]
			XCTAssertTrue(customImageDetailView.exists, "CustomImageDetailView 화면으로 이동되지 않았습니다.")
			
			self.app.buttons["backButton"].tap()
			XCTAssertFalse(customImageDetailView.exists, "뒤로가기 버튼을 클릭할 수 없습니다.")
			
			customImageView.press(forDuration: 1.5)
			
			let deleteButton = self.app.buttons["deleteButton"]
			XCTAssertTrue(deleteButton.exists, "삭제 메뉴가 표시되지 않습니다.")
			
			deleteButton.tap()
			XCTAssertFalse(customImageView.exists, "CustomImageView가 삭제되지 않았습니다.")
		}
	}
}
