//
//  MainSceneViewUITests.swift
//  CondeeUITests
//
//  Created by woo0 on 11/2/24.
//

import XCTest
@testable import Condee

@MainActor
final class MainSceneUITests: XCTestCase {
	private let app = XCUIApplication()
	
    override func setUpWithError() throws {
		app.launchArguments = ["-UITesting"]
		app.launch()
    }
	
	func testElementsMainSceneView() throws {
		let appNameLabel = app.staticTexts["Condee"]
		XCTAssertTrue(appNameLabel.exists, "앱 이름이 표시되지 않습니다.")
		
		let gridView = app.otherElements["CustomImagesGridView"]
		XCTAssertTrue(gridView.waitForExistence(timeout: 5), "CustomImagesGridView가 존재해야 합니다.")
		
		let addButton = app.buttons["AddButton"]
		XCTAssertTrue(addButton.exists, "새로 만들기 버튼이 없습니다.")
	}
	
    func testAddButtonOpensCreateCustomImageView() throws {
		let addButton = app.buttons["AddButton"]
		XCTAssertTrue(addButton.exists, "새로 만들기 버튼이 없습니다.")
		addButton.tap()
		
		XCTAssertTrue(app.otherElements["CreateCustomImageScene"].exists, "CreateCustomImageView를 불러올 수 없습니다.")
    }
	
	func testNavigationOnImageTap() {
		let firstCustomImage = app.buttons["CustomImageView"].firstMatch
		XCTAssertTrue(firstCustomImage.waitForExistence(timeout: 5), "첫 번째 이미지가 존재하지 않습니다.")
		firstCustomImage.tap()
		
		XCTAssertTrue(app.images["DetailCustomImage"].waitForExistence(timeout: 5), "이미지 탭 후 네비게이션이 되지 않습니다.")
	}
	
	func testContextMenuDeleteButton() {
		let gridView = app.otherElements["CustomImagesGridView"]
		XCTAssertTrue(gridView.waitForExistence(timeout: 5), "CustomImagesGridView가 존재해야 합니다.")
		
		let buttons = app.buttons.matching(identifier: "CustomImageView")
		
		let initialCount = buttons.count
		let firstCustomImage = buttons.firstMatch
		XCTAssertTrue(firstCustomImage.waitForExistence(timeout: 5), "첫 번째 이미지가 존재하지 않음")
		
		firstCustomImage.press(forDuration: 1.0)
		let deleteButton = app.buttons["DeleteButton"]
		
		XCTAssertTrue(deleteButton.exists, "삭제 버튼이 존재하지 않음")
		
		deleteButton.tap()
		
		let finalCount = app.buttons.matching(identifier: "CustomImageView").count
		XCTAssertEqual(finalCount, initialCount - 1, "이미지 삭제 후 개수가 하나 줄어야 함")
	}
	
	func testPinchZoomGesture() {
		let gridView = app.otherElements["CustomImagesGridView"]
		XCTAssertTrue(gridView.waitForExistence(timeout: 5), "CustomImagesGridView가 존재해야 합니다.")
		
		gridView.pinch(withScale: 0.5, velocity: -1.0)
		gridView.pinch(withScale: 2.0, velocity: 1.0)
	}
}
