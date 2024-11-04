//
//  MainSceneView.swift
//  Condee
//
//  Created by woo0 on 11/2/24.
//

import SwiftUI

struct MainSceneView: View {
	@StateObject var viewModel: MainSceneViewModel
	
	init(viewModel: MainSceneViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
    var body: some View {
		Text("Hello World!")
    }
}
