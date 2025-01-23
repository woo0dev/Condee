//
//  SparkleAnimationView.swift
//  Condee
//
//  Created by woo0 on 12/23/24.
//

import SwiftUI

struct SparklesAnimationView: View {
	@State private var sparklePositions: [CGPoint] = []
	@State private var opacityValues: [Double] = []
	@State private var sparkleIndex = 0
	
	let sparkleCount = 100
	let animationDuration: Double = 1.0
	let delayBetweenSparkles: Double = 0.3
	
	let size: CGSize
	
	var body: some View {
		ZStack {
			ForEach(0..<sparkleCount, id: \.self) { index in
				Image(systemName: "sparkle")
					.font(.system(size: 30))
					.foregroundColor(.yellow)
					.opacity(opacityValues[safe: index] ?? 0.0)
					.position(sparklePositions[safe: index] ?? .zero)
			}
		}
		.frame(width: size.width, height: size.height)
		.onAppear {
			opacityValues = Array(repeating: 0.0, count: 100)
			sparklePositions = (0..<sparkleCount).map { _ in
				CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
			}
			startSparklesAnimation()
		}
	}
	
	private func startSparklesAnimation() {
		sparkleIndex = 0
		
		Timer.scheduledTimer(withTimeInterval: delayBetweenSparkles, repeats: true) { timer in
			withAnimation(.easeInOut(duration: animationDuration)) {
				opacityValues[sparkleIndex] = 1.0
				if sparkleIndex - 3 >= 0 {
					opacityValues[sparkleIndex - 3] = 0.0
				}
			}
			
			if sparkleIndex >= sparkleCount - 1 {
				timer.invalidate()
			} else {
				sparkleIndex += 1
			}
		}
	}
}
