//
//  MainSceneViewUITests.swift
//  CondeeUITests
//
//  Created by woo0 on 11/2/24.
//

import XCTest

final class MainSceneViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
		let app = XCUIApplication()
		app.launch()
    }
	
	@MainActor
	func testElementsMainSceneView() throws {
		let app = XCUIApplication()
		app.launch()
		
		let addButton = app.buttons["addButton"]
		XCTAssertTrue(addButton.exists, "새로 만들기 버튼이 없습니다.")
		
		let appNameLabel = app.staticTexts["Condee"]
		XCTAssertTrue(appNameLabel.exists, "앱 이름이 표시되지 않습니다.")
		
		for index in 0..<4 {
			let imageElement = app.images["image\(index)"]
			XCTAssertTrue(imageElement.exists, "이미지\(index)가 표시되지 않습니다.")
		}
	}

    @MainActor
    func testAddButtonOpensCreateCustomImageView() throws {
        let app = XCUIApplication()
        app.launch()

		app.buttons["addButton"].tap()
		
		let createCustomImageView = app.otherElements["CreateCustomImageView"]
		XCTAssertTrue(createCustomImageView.exists, "CreateCustomImageView를 불러올 수 없습니다.")
		
		app.buttons["backButton"].tap()
		XCTAssertFalse(createCustomImageView.exists, "뒤로가기 버튼을 클릭할 수 없습니다.")
    }
}
