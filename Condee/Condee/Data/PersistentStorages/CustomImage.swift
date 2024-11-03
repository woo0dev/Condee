//
//  CustomImageStorage.swift
//  Condee
//
//  Created by woo0 on 11/2/24.
//

import Foundation
import SwiftData

@Model
final class CustomImage: Identifiable, Hashable {
	@Attribute(.unique) var id: UUID = UUID()
	var timestamp: Date = Date()
	var imageURL: URL
	
	init(imageURL: URL) {
		self.imageURL = imageURL
	}
}
