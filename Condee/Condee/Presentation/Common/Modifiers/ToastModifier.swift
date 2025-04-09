//
//  ToastModifier.swift
//  Condee
//
//  Created by woo0 on 1/23/25.
//

import SwiftUI

struct ToastModifier: ViewModifier {
	@Binding var isPresented: Bool
	
	let message: String
	
	func body(content: Content) -> some View {
		ZStack {
			content
			if isPresented {
				VStack {
					Spacer()
					HStack {
						Spacer()
						Text(message)
							.foregroundStyle(.black)
							.padding(.trailing, 20)
							.lineSpacing(5)
						Spacer()
					}
					.frame(maxWidth: .infinity, maxHeight: 50)
					.background(Color(UIColor.lightGray))
					.cornerRadius(20)
					.animation(.easeInOut, value: isPresented)
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
							isPresented = false
						}
					}
					.padding(20)
				}
			}
		}
	}
}
