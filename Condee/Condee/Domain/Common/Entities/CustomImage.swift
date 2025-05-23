//
//  CustomImage.swift
//  Condee
//
//  Created by woo0 on 11/3/24.
//

import Foundation
import SwiftData

@Model
final class CustomImage: Identifiable, Hashable {
	@Attribute(.unique) var id: UUID
	var timestamp: Date = Date()
	var imageURL: URL
	
	init(id: UUID, imageURL: URL) {
		self.id = id
		self.imageURL = imageURL
	}
}
