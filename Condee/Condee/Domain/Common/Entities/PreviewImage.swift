//
//  PreviewImage.swift
//  Condee
//
//  Created by woo0 on 1/22/25.
//

import SwiftUI

struct PreviewImage: Transferable {
	static var transferRepresentation: some TransferRepresentation {
		ProxyRepresentation(exporting: \.image)
	}
	
	public var caption: String
	public var image: Image
}
