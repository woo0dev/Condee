//
//  CustomImageStorage.swift
//  Condee
//
//  Created by woo0 on 11/2/24.
//

import Foundation
import SwiftData

@Model
final class CustomImageStorage {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
