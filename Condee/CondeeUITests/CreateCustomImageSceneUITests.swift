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
		continueAfterFailure = false
		app.launch()
	}
	
	func testCreateButtonExists() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let createButton = app.buttons["CreateButton"]
		XCTAssertTrue(createButton.exists, "생성 버튼이 존재하지 않습니다.")
		createButton.tap()
		
		let resultCustomImageView = app.otherElements["ResultCustomImageView"]
		XCTAssertTrue(resultCustomImageView.exists, "커스텀 이미지 결과 뷰가 존재하지 않습니다.")
	}
	
	func testGridPatternBackgroundExists() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let backgroundView = app.otherElements["GridPatternBackgroundView"]
		XCTAssertTrue(backgroundView.exists, "격자무늬 배경이 존재하지 않습니다.")
	}
	
	func testBottomButtonsExist() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addPhotoButton = app.buttons["AddPhotoButton"]
		let addEmojiButton = app.buttons["AddEmojiButton"]
		let addTextButton = app.buttons["AddTextButton"]
		
		XCTAssertTrue(addPhotoButton.exists, "사진 추가 버튼이 존재하지 않습니다.")
		XCTAssertTrue(addEmojiButton.exists, "이모티콘 추가 버튼이 존재하지 않습니다.")
		XCTAssertTrue(addTextButton.exists, "텍스트 추가 버튼이 존재하지 않습니다.")
	}
	
	func testPhotoAddButtonActionSheet() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addPhotoButton = app.buttons["AddPhotoButton"]
		addPhotoButton.tap()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			let backgroundImageOption = self.app.buttons["BackgroundImageOption"]
			let addImageOption = self.app.buttons["AddImageOption"]
			let cancelOption = self.app.buttons["CancelOption"]
			
			XCTAssertTrue(backgroundImageOption.exists, "배경사진 버튼이 존재하지 않습니다.")
			XCTAssertTrue(addImageOption.exists, "추가 사진 버튼이 존재하지 않습니다.")
			XCTAssertTrue(cancelOption.exists, "취소 버튼이 존재하지 않습니다.")
		}
	}
	
	func testBackgroundImageAddition() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addPhotoButton = app.buttons["AddPhotoButton"]
		addPhotoButton.tap()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			let backgroundImageOption = self.app.buttons["BackgroundImageOption"]
			XCTAssertTrue(backgroundImageOption.exists, "배경사진 버튼이 존재하지 않습니다.")
			backgroundImageOption.tap()
			
			let photosPickerView = self.app.sheets["PhotosPickerView"]
			XCTAssertTrue(photosPickerView.waitForExistence(timeout: 2), "PhotosPickerView가 존재하지 않습니다.")
			
			let firstPhoto = photosPickerView.collectionViews.cells.element(boundBy: 0)
			XCTAssertTrue(firstPhoto.exists, "선택 가능한 첫 번째 사진이 없습니다.")
			firstPhoto.tap()
			
			let gridPatternBackgroundWithImage = self.app.otherElements["GridPatternBackgroundWithImage"]
			XCTAssertTrue(gridPatternBackgroundWithImage.waitForExistence(timeout: 2), "배경 이미지가 격자 무늬 배경에 존재하지 않습니다.")
			
			let gridPatternBackgroundFrame = gridPatternBackgroundWithImage.frame
			let deviceScreenFrame = self.app.windows.element(boundBy: 0).frame
			XCTAssertEqual(gridPatternBackgroundFrame, deviceScreenFrame, "배경 이미지가 격자 배경 크기에 맞게 조정되지 않았습니다.")
		}
	}
	
	func testAddAdditionalPhoto() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addPhotoButton = app.buttons["AddPhotoButton"]
		addPhotoButton.tap()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			let addImageOption = self.app.buttons["AddImageOption"]
			XCTAssertTrue(addImageOption.exists, "추가 사진 버튼이 존재하지 않습니다.")
			addImageOption.tap()
			
			let photosPickerView = self.app.sheets["PhotosPickerView"]
			XCTAssertTrue(photosPickerView.waitForExistence(timeout: 2), "PhotosPickerView가 존재하지 않습니다.")
			
			let firstPhoto = photosPickerView.collectionViews.cells.element(boundBy: 0)
			XCTAssertTrue(firstPhoto.exists, "선택 가능한 첫 번째 사진이 없습니다.")
			firstPhoto.tap()
			
			let additionalPhotoView = self.app.otherElements["AdditionalPhotoView"]
			XCTAssertTrue(additionalPhotoView.waitForExistence(timeout: 2), "추가된 사진이 배경뷰 위에 존재하지 않습니다.")
			
			let backgroundView = self.app.otherElements["GridPatternBackgroundView"]
			let backgroundFrame = backgroundView.frame
			let additionalPhotoFrame = additionalPhotoView.frame
			
			XCTAssertTrue(backgroundFrame.contains(additionalPhotoFrame), "추가된 사진이 배경뷰 밖으로 나갔습니다.")
			
			additionalPhotoView.gestureTestOnElement(in: backgroundView)
		}
	}
	
	func testAddEmoji() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addEmojiButton = app.buttons["AddEmojiButton"]
		addEmojiButton.tap()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			let emojisView = self.app.otherElements["EmojisView"]
			let emojisGridView = emojisView.collectionViews["EmojisGridView"]
			let firstEmoji = emojisGridView.cells.element(boundBy: 0)
			firstEmoji.tap()
			
			let addedEmojiView = self.app.otherElements["AddedEmojiView"]
			addedEmojiView.gestureTestOnElement(in: self.app.otherElements["GridPatternBackgroundView"])
		}
	}
	
	func testTextAddButtonActionSheet() {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addTextButton = app.buttons["AddTextButton"]
		addTextButton.tap()
		
		let extractImageOption = app.buttons["ExtractImageOption"]
		let directInputOption = app.buttons["DirectInputOption"]
		let cancelOption = app.buttons["CancelOption"]
		
		XCTAssertTrue(extractImageOption.exists, "이미지에서 추출 버튼이 존재하지 않습니다.")
		XCTAssertTrue(directInputOption.exists, "직접 입력 버튼이 존재하지 않습니다.")
		XCTAssertTrue(cancelOption.exists, "취소 버튼이 존재하지 않습니다.")
	}
	
	func testExtractImageOptionOpensImagePicker() throws {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addTextButton = app.buttons["AddTextButton"]
		addTextButton.tap()
		
		let extractImageOption = app.buttons["ExtractImageOption"]
		extractImageOption.tap()
		
		let photoPickerView = app.collectionViews["PhotosPickerView"]
		XCTAssertTrue(photoPickerView.exists)
		
		let extractImageView = app.otherElements["ExtractImageView"]
		XCTAssertTrue(extractImageView.waitForExistence(timeout: 5))
		
		extractImageView.gestureTestOnElement(in: app.otherElements["GridPatternBackgroundView"])
	}
	
	func testDirectInputOptionOpensTextInputView() throws {
		let addButton = self.app.buttons["AddButton"]
		addButton.tap()
		
		let addTextButton = app.buttons["AddTextButton"]
		addTextButton.tap()
		
		let directInputOption = app.buttons["DirectInputOption"]
		directInputOption.tap()
		
		let textInputView = app.otherElements["TextInputView"]
		XCTAssertTrue(textInputView.exists)
		
		let colorPickerButton = app.buttons["ColorPickerButton"]
		XCTAssertTrue(colorPickerButton.exists)
		colorPickerButton.tap()
		
		let colorPickerView = app.otherElements["ColorPickerView"]
		XCTAssertTrue(colorPickerView.exists, "색상 선택기가 열리지 않았습니다.")
		
		let colorOptionButton = app.buttons["ColorOptionButton1"]
		XCTAssertTrue(colorOptionButton.exists, "색상 옵션 버튼이 존재하지 않습니다.")
		colorOptionButton.tap()
		
		let textElement = app.staticTexts["TextInputViewText"]
		XCTAssertTrue(textElement.exists, "텍스트가 존재하지 않습니다.")
		
		textInputView.gestureTestOnElement(in: app.otherElements["GridPatternBackgroundView"])
	}
}

extension XCUIElement {
	func gestureTestOnElement(in backgroundView: XCUIElement) {
		let backgroundFrame = backgroundView.frame
		
		self.pinch(withScale: 1.5, velocity: 1.0)
		XCTAssertTrue(backgroundFrame.contains(self.frame), "크기 조절 후 요소가 배경뷰 밖으로 나갔습니다.")
		
		let startCoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
		let endCoordinate = backgroundView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
		startCoordinate.press(forDuration: 0.1, thenDragTo: endCoordinate)
		XCTAssertTrue(backgroundFrame.contains(self.frame), "위치 이동 후 요소가 배경뷰 밖으로 나갔습니다.")
		
		self.rotate(.pi / 4, withVelocity: 1.0)
		XCTAssertTrue(backgroundFrame.contains(self.frame), "회전 후 요소가 배경뷰 밖으로 나갔습니다.")
	}
}
