//
//  CondeeApp.swift
//  Condee
//
//  Created by woo0 on 11/2/24.
//

import SwiftUI
import SwiftData

@main
struct CondeeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
			CustomImage.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
			MainSceneView(viewModel: DependencyContainer.shared.makeMainSceneViewModel(modelContainer: sharedModelContainer))
        }
    }
}
