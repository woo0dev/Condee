//
//  Array+Extension.swift
//  Condee
//
//  Created by woo0 on 11/19/24.
//

import Foundation

extension Array {
	subscript(safe index: Int) -> Element? {
		return (index >= 0 && index < count) ? self[index] : nil
	}
}
