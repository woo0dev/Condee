//
//  CreateCustomImageSceneUITests.swift
//  CondeeUITests
//
//  Created by woo0 on 11/7/24.
//

import XCTest

@MainActor
final class CreateCustomImageSceneUITests: XCTestCase {
	private let app = XCUIApplication()
	
	override func setUpWithError() throws {
		app.launchArguments = ["-UITesting"]
		app.launch()
		mainSceneAddButtonTest()
	}
	
	func testInitialUIComponentsExistence() {
		XCTAssertTrue(app.buttons["CreateButton"].exists, "생성 버튼이 존재하지 않습니다.")
		XCTAssertTrue(app.otherElements["GridPatternBackgroundView"].exists, "격자무늬 배경이 존재하지 않습니다.")
		XCTAssertTrue(app.buttons["AddPhotoButton"].exists, "사진 추가 버튼이 존재하지 않습니다.")
		XCTAssertTrue(app.buttons["AddStickerButton"].exists, "스티커 추가 버튼이 존재하지 않습니다.")
		XCTAssertTrue(app.buttons["AddTextButton"].exists, "텍스트 추가 버튼이 존재하지 않습니다.")
	}
	
	func testCreateButtonTriggers() {
		app.buttons["CreateButton"].tap()
		XCTAssertTrue(app.images["CustomImageView"].waitForExistence(timeout: 5), "커스텀 이미지가 존재하지 않습니다.")
	}
	
	func testPhotoAddActionSheetOptionsExistence() {
		app.buttons["AddPhotoButton"].tap()
		XCTAssertTrue(app.sheets.buttons.allElementsBoundByIndex[0].exists, "배경 사진 옵션이 존재하지 않습니다.")
		XCTAssertTrue(app.sheets.buttons.allElementsBoundByIndex[1].exists, "추가 사진 옵션이 존재하지 않습니다.")
		XCTAssertTrue(app.sheets.buttons.allElementsBoundByIndex[2].exists, "취소 옵션이 존재하지 않습니다.")
	}
	
	func testBackgroundImageOptionTriggers() {
		app.buttons["AddPhotoButton"].tap()
		app.sheets.buttons.allElementsBoundByIndex[0].tap()
		
		let photosPickerView = app.scrollViews.element
		XCTAssertTrue(photosPickerView.waitForExistence(timeout: 5), "PhotosPickerView가 존재하지 않습니다.")
		
		let firstPhoto = photosPickerView.images.firstMatch
		XCTAssertTrue(firstPhoto.waitForExistence(timeout: 5), "선택 가능한 첫 번째 사진이 없습니다.")
		firstPhoto.tap()
		
		let gridPatternBackgroundWithImage = app.images["GridPatternBackgroundWithImage"]
		XCTAssertTrue(gridPatternBackgroundWithImage.waitForExistence(timeout: 5), "배경 이미지가 존재하지 않습니다.")
	}
	
	func testAdditionalPhotoOptionTriggers() {
		app.buttons["AddPhotoButton"].tap()
		app.sheets.buttons.allElementsBoundByIndex[1].tap()
		
		let photosPickerView = app.scrollViews.element
		XCTAssertTrue(photosPickerView.waitForExistence(timeout: 5), "PhotosPickerView가 존재하지 않습니다.")
		
		let firstPhoto = photosPickerView.images.firstMatch
		XCTAssertTrue(firstPhoto.waitForExistence(timeout: 5), "선택 가능한 첫 번째 사진이 없습니다.")
		firstPhoto.tap()
		
		let additionalPhotoView = app.images["AddedImageView"]
		XCTAssertTrue(additionalPhotoView.waitForExistence(timeout: 5), "추가된 사진이 존재하지 않습니다.")
		
		let backgroundView = app.otherElements["GridPatternBackgroundView"]
		let backgroundFrame = backgroundView.frame
		let additionalPhotoFrame = additionalPhotoView.frame
		XCTAssertTrue(backgroundFrame.contains(additionalPhotoFrame), "추가된 사진이 배경뷰 밖으로 나갔습니다.")
		
		additionalPhotoView.gestureTestToImage(in: app)
	}
	
	func testAddStickerTriggers() {
		app.buttons["AddStickerButton"].tap()
		
		let stickersGridView = app.otherElements["StickersGridView"]
		XCTAssertTrue(stickersGridView.exists, "스티커 그리드가 존재하지 않습니다.")
		
		let firstSticker = stickersGridView.buttons.element(boundBy: 0)
		XCTAssertTrue(firstSticker.exists, "선택할 수 있는 스티커가 존재하지 않습니다.")
		firstSticker.tap()
		
		let addedStickerView = app.images["AddedImageView"]
		XCTAssertTrue(addedStickerView.exists, "스티커가 추가되지 않았습니다.")
		addedStickerView.gestureTestToImage(in: app)
	}
	
	func testTextAddActionSheetOptionsExistence() {
		app.buttons["AddTextButton"].tap()
		XCTAssertTrue(app.sheets.buttons.allElementsBoundByIndex[0].exists, "이미지에서 추출 옵션이 존재하지 않습니다.")
		XCTAssertTrue(app.sheets.buttons.allElementsBoundByIndex[1].exists, "직접 입력 옵션이 존재하지 않습니다.")
		XCTAssertTrue(app.sheets.buttons.allElementsBoundByIndex[2].exists, "취소 옵션이 존재하지 않습니다.")
	}
	
	func testExtractImageOptionTriggers() throws {
		app.buttons["AddTextButton"].tap()
		app.sheets.buttons.allElementsBoundByIndex[0].tap()
		
		let photosPickerView = app.scrollViews.element
		XCTAssertTrue(photosPickerView.waitForExistence(timeout: 5), "PhotosPickerView가 존재하지 않습니다.")
		
		let firstPhoto = photosPickerView.images.firstMatch
		XCTAssertTrue(firstPhoto.waitForExistence(timeout: 5), "선택 가능한 첫 번째 사진이 없습니다.")
		firstPhoto.tap()
		
		let extractImageView = app.images["ExtractImageView"]
		XCTAssertTrue(extractImageView.waitForExistence(timeout: 5), "텍스트 추출 이미지가 존재하지 않습니다.")
		
		let cancelButton = app.buttons["CancelButton"]
		XCTAssertTrue(cancelButton.exists, "취소 버튼이 존재하지 않습니다.")
		
		let extractbutton = app.buttons["ExtractButton"]
		XCTAssertTrue(extractbutton.exists, "배경 제거하기 버튼이 존재하지 않습니다.")
		extractbutton.tap()
		
		let extractedImage = app.images["ExtractedImage"]
		XCTAssertTrue(extractedImage.waitForExistence(timeout: 5), "추출된 이미지가 존재하지 않습니다.")
		
		let doneButton = app.buttons["DoneButton"]
		XCTAssertTrue(doneButton.exists, "완료 버튼이 존재하지 않습니다.")
		doneButton.tap()
		
		let addedExtractImageView = app.images["AddedImageView"]
		XCTAssertTrue(addedExtractImageView.waitForExistence(timeout: 5), "텍스트 추출 이미지가 존재하지 않습니다.")
		
		addedExtractImageView.gestureTestToImage(in: app)
	}
	
	func testDirectInputOptionTriggers() throws {
		app.buttons["AddTextButton"].tap()
		app.sheets.buttons.allElementsBoundByIndex[1].tap()
		
		let textInputView = app.textViews["TextInputView"]
		XCTAssertTrue(textInputView.waitForExistence(timeout: 5), "텍스트 입력 뷰가 추가되지 않았습니다.")
		textInputView.typeText("테스트 텍스트")
		
		let colorPickerButton = app.buttons["ColorPickerButton"]
		XCTAssertTrue(colorPickerButton.waitForExistence(timeout: 5), "색상 선택기 버튼이 존재하지 않습니다.")
		colorPickerButton.tap()
		
		let colorPickerView = app.otherElements["UIColorPickerView"]
		XCTAssertTrue(colorPickerView.waitForExistence(timeout: 5), "색상 선택기 뷰가 존재하지 않습니다.")
		
		let colorOptionButton = colorPickerView.buttons.allElementsBoundByIndex[3]
		XCTAssertTrue(colorOptionButton.exists, "색상 옵션 버튼이 존재하지 않습니다.")
		colorOptionButton.tap()
		
		colorPickerView.buttons.allElementsBoundByIndex[1].tap()
		
		let initialSize = textInputView.frame.size
		let initialRotation = textInputView.frame.origin
		
		let rotationAdjustButton = app.images["RotationAdjustButton"]
		XCTAssertTrue(rotationAdjustButton.exists, "회전 조정 버튼이 존재하지 않습니다.")
		
		rotationAdjustButton.press(forDuration: 0.1, thenDragTo: textInputView)
		
		let sizeAdjustButton = app.images["SizeAdjustButton"]
		XCTAssertTrue(sizeAdjustButton.exists, "크기 조정 버튼이 존재하지 않습니다.")
		
		sizeAdjustButton.press(forDuration: 0.1, thenDragTo: textInputView)
		
		let finalSize = textInputView.frame.size
		let finalRotation = textInputView.frame.origin
		
		XCTAssertNotEqual(initialSize.width, finalSize.width, "크기가 변경되지 않았습니다.")
		XCTAssertNotEqual(initialRotation, finalRotation, "회전이 되지 않았습니다.")
		
		let elementDeleteButton = app.buttons["ElementDeleteButton"]
		XCTAssertTrue(elementDeleteButton.exists, "삭제 버튼이 존재하지 않습니다.")
		elementDeleteButton.tap()
		
		XCTAssertFalse(textInputView.exists, "삭제 버튼이 동작하지 않습니다.")
	}
}

extension CreateCustomImageSceneUITests {
	func mainSceneAddButtonTest() {
		let addButton = app.buttons["AddButton"]
		XCTAssertTrue(addButton.exists, "추가 버튼이 존재하지 않습니다.")
		addButton.tap()
	}
}

extension XCUIElement {
	func gestureTestToImage(in app: XCUIApplication) {
		let initialSize = self.frame.size
		let initialRotation = self.frame.origin
		
		let adjustButton = app.images["AdjustButton"]
		XCTAssertTrue(adjustButton.exists, "조정 버튼이 존재하지 않습니다.")
		
		adjustButton.press(forDuration: 0.1, thenDragTo: app.images["AddedImageView"])
		
		let finalSize = self.frame.size
		let finalRotation = self.frame.origin
		
		XCTAssertNotEqual(initialSize.width, finalSize.width, "크기가 변경되지 않았습니다.")
		XCTAssertNotEqual(initialRotation, finalRotation, "회전이 되지 않았습니다.")
		
		let elementDeleteButton = app.buttons["ElementDeleteButton"]
		XCTAssertTrue(elementDeleteButton.exists, "삭제 버튼이 존재하지 않습니다.")
		elementDeleteButton.tap()
		XCTAssertFalse(self.exists, "삭제 버튼이 동작하지 않습니다.")
	}
}
