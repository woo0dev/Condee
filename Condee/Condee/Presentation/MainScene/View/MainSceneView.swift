//
//  MainSceneView.swift
//  Condee
//
//  Created by woo0 on 11/2/24.
//

import SwiftUI
import SwiftData

struct MainSceneView: View {
	@Environment(\.scenePhase) var scenePhase
	
	@StateObject var viewModel: MainSceneViewModel
	
	@State private var navigationPath = NavigationPath()
	
	let dependencyContainer: DependencyContainer
	
    var body: some View {
		NavigationStack(path: $navigationPath) {
			ZStack {
				VStack(alignment: .leading) {
					HeaderView(title: "Condee")
					CustomImagesGridView(viewModel: viewModel, navigationPath: $navigationPath)
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
				if viewModel.customImages.isEmpty {
					Text("새로운 이미지를 생성해주세요.")
						.foregroundStyle(.gray)
				}
			}
			.navigationDestination(for: Int.self) { index in
				if let image = viewModel.images[index].self {
					DetailCustomImageSceneView(customImage: viewModel.customImages[index], previewImage: PreviewImage(caption: "PreviewImage", image: Image(uiImage: image)))
						.onDisappear {
							viewModel.endNavigation()
						}
				}
			}
			.navigationDestination(for: String.self, destination: { value in
				if value == "CreateCustomImageSceneView" {
					CreateCustomImageSceneView(viewModel: dependencyContainer.makeCreateCustomImageSceneViewModel(repository: viewModel.customImageRepository), navigationPath: $navigationPath, dependencyContainer: dependencyContainer)
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
		.onChange(of: scenePhase) { _, newPhase in
			if newPhase == .background {
				viewModel.updateNumberOfColumns()
			}
		}
    }
}

#Preview {
	let dependencyContainer: DependencyContainer = .init()
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
	let preViewModel = dependencyContainer.makeMainSceneViewModel(modelContainer: sharedModelContainer)
	
	MainSceneView(viewModel: preViewModel, dependencyContainer: dependencyContainer)
		.onAppear {
			preViewModel.customImages = dummyImages
		}
}
