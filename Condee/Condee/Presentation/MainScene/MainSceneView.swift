//
//  MainSceneView.swift
//  Condee
//
//  Created by woo0 on 11/2/24.
//

import SwiftUI
import SwiftData

struct MainSceneView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var CustomImageStorages: [CustomImageStorage]

    var body: some View {
		Text("Hello World!")
    }
}
