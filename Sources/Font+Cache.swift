//
//  Font+Cache.swift
//  Demo
//
//  Created by Andreas Verhoeven on 31/05/2022.
//

import UIKit

extension Font {
	fileprivate static var cache = NSCache<CacheKey, UIFont>()

	internal func cachedOrCreatedFont() -> UIFont {
		guard isOnlyTextStyle == false else {
			return uncachedFont()
		}
		
		let cache = Self.cache
		let key = CacheKey(font: self, contentSizeCategory: UITraitCollection.current.preferredContentSizeCategory)
		if let cachedFont = cache.object(forKey: key) {
			return cachedFont
		}

		let createdFont = uncachedFont()
		if cache.countLimit == 0 {
			cache.countLimit = 25
		}
		cache.setObject(createdFont, forKey: key)
		return createdFont
	}

	fileprivate final class CacheKey: NSObject {
		let font: Font
		let contentSizeCategory: UIContentSizeCategory

		init(font: Font, contentSizeCategory: UIContentSizeCategory) {
			self.font = font
			self.contentSizeCategory = contentSizeCategory
		}

		override var hash: Int {
			var result = 1
			let prime = 31
			result = prime &* result &+ font.hashValue
			result = prime &* result &+ contentSizeCategory.rawValue.hashValue
			return result
		}

		override func isEqual(_ object: Any?) -> Bool {
			guard let value = object as? CacheKey else { return false }
			return value.font == font && value.contentSizeCategory == contentSizeCategory
		}
	}
}
