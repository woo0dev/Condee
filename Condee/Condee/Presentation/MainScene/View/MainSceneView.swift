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
	
	init(viewModel: MainSceneViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
    var body: some View {
		NavigationStack {
			ZStack {
				VStack(alignment: .leading) {
					HeaderView(title: "Condee")
					CustomImagesGridView(viewModel: viewModel)
				}
				.padding([.top, .leading, .trailing], 20)
				AddButtonView(viewModel: viewModel)
			}
			.navigationDestination(for: CustomImage.self) { image in
				DetailCustomImageSceneView(customImage: image)
			}
			.navigationDestination(isPresented: $viewModel.isAddButtonTapped) {
				CreateCustomImageSceneView()
			}
		}
		.onAppear {
			viewModel.fetchAll()
		}
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
	let dummyImages: [CustomImage] = [CustomImage(imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(imageURL: URL(string: "https://picsum.photos/1179/2556")!), CustomImage(imageURL: URL(string: "https://picsum.photos/1179/2556")!)]
	let preViewModel = DependencyContainer.shared.makeMainSceneViewModel(modelContainer: sharedModelContainer)
	
	MainSceneView(viewModel: preViewModel)
		.onAppear {
			preViewModel.customImages = dummyImages
		}
}
