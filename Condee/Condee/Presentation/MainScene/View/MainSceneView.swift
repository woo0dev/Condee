//
//  MainSceneView.swift
//  Condee
//
//  Created by woo0 on 11/2/24.
//

import SwiftUI
import SwiftData

struct MainSceneView: View {
	@StateObject var viewModel: MainSceneViewModel
	
	@State private var navigationPath = NavigationPath()
	
	init(viewModel: MainSceneViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
    var body: some View {
		NavigationStack(path: $navigationPath) {
			ZStack {
				VStack(alignment: .leading) {
					HeaderView(title: "Condee")
					CustomImagesGridView(viewModel: viewModel)
				}
				.padding([.top, .leading, .trailing], 20)
				VStack {
					Spacer()
					HStack {
						Spacer()
						NavigationLink(value: "CreateCustomImageSceneView", label: {
							Label("새로 만들기", systemImage: "plus")
						})
						.accessibilityIdentifier("AddButton")
						.buttonStyle(RoundedRectangleButtonStyle())
						.padding(20)
					}
				}
			}
			.navigationDestination(for: CustomImage.self) { image in
				DetailCustomImageSceneView(customImage: image)
			}
			.navigationDestination(for: String.self, destination: { value in
				if value == "CreateCustomImageSceneView" {
					CreateCustomImageSceneView(viewModel: DependencyContainer.shared.makeCreateCustomImageSceneViewModel(repository: viewModel.customImageRepository), navigationPath: $navigationPath)
				}
			})
		}
		.onAppear {
			viewModel.fetchAll()
		}
		.onChange(of: navigationPath, {
			if navigationPath.isEmpty {
				viewModel.fetchAll()
			}
		})
    }
}

#Preview {
	let sharedModelContainer: ModelContainer = {
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
	let dummyImages: [CustomImage] = [CustomImage(id: UUID(), imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(id: UUID(), imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(id: UUID(), imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(id: UUID(), imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(id: UUID(), imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(id: UUID(), imageURL: URL(string: "https://picsum.photos/1179/2556")!)]
	let preViewModel = DependencyContainer.shared.makeMainSceneViewModel(modelContainer: sharedModelContainer)
	
	MainSceneView(viewModel: preViewModel)
		.onAppear {
			preViewModel.customImages = dummyImages
		}
}
