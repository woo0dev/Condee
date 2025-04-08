//
//  BackGestureEnabler.swift
//  Condee
//
//  Created by woo0 on 4/6/25.
//

import SwiftUI

struct BackGestureEnabler: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> BackGestureEnablerViewController {
		BackGestureEnablerViewController()
	}

	func updateUIViewController(_ uiViewController: BackGestureEnablerViewController, context: Context) { }
}

final class BackGestureEnablerViewController: UIViewController {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		navigationController?.interactivePopGestureRecognizer?.isEnabled = true
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
}
