//
//  ImageRepositoryImpl.swift
//  Condee
//
//  Created by woo0 on 1/16/25.
//

import Combine
import SwiftUI

final class ImageRepositoryImpl: ImageRepository {
	private let cache = NSCache<NSURL, UIImage>()
	
	func fetchImages(from customImages: [CustomImage]) -> AnyPublisher<[UIImage?], Never> {
		return Publishers.MergeMany(
			customImages.map { customImage in
				return fetchImage(from: customImage.imageURL)
			}
		)
		.collect()
		.eraseToAnyPublisher()
	}
	
	func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
		if let cachedImage = cache.object(forKey: url as NSURL) {
			return Just(cachedImage).eraseToAnyPublisher()
		}
		
		return URLSession.shared.dataTaskPublisher(for: url)
			.map { data, _ in UIImage(data: data) }
			.handleEvents(receiveOutput: { [weak self] image in
				if let image = image {
					self?.cache.setObject(image, forKey: url as NSURL)
				}
			})
			.replaceError(with: nil)
			.eraseToAnyPublisher()
	}
}
