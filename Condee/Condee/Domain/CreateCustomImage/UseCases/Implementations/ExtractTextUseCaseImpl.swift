//
//  ExtractTextUseCaseImpl.swift
//  Condee
//
//  Created by woo0 on 12/20/24.
//

import SwiftUI
import opencv2

final class ExtractTextUseCaseImpl: ExtractTextUseCase {
	func execute(image: UIImage) -> [UIImage] {
		let mat = Mat(uiImage: image)
		let clusters: Int = 2
		
		let reshaped = mat.reshape(channels: 1, rows: mat.rows() * mat.cols())
		reshaped.convert(to: reshaped, rtype: CvType.CV_32F)
		
		let labels = Mat()
		let centers = Mat()
		Core.kmeans(
			data: reshaped, K: Int32(clusters),
			bestLabels: labels,
			criteria: TermCriteria(type: TermCriteria.count + TermCriteria.eps, maxCount: 10, epsilon: 1.0),
			attempts: 3,
			flags: 2,
			centers: centers
		)
		
		let segmented = labels.reshape(channels: 1, rows: mat.rows())
		segmented.convert(to: segmented, rtype: CvType.CV_8U)
		
		let mask = Mat()
		Core.inRange(src: segmented, lowerb: Scalar(Double(clusters-1)), upperb: Scalar(Double(clusters-1)), dst: mask)
		
		var results = [UIImage]()
		for i in 0..<clusters {
			let mask = Mat()
			Core.inRange(src: segmented, lowerb: Scalar(Double(i)), upperb: Scalar(Double(i)), dst: mask)
			
			let clusterImage = Mat()
			Core.bitwise_and(src1: mat, src2: mat, dst: clusterImage, mask: mask)
			results.append(clusterImage.toUIImage())
		}
		
		return results
	}
}
