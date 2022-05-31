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
		let cache = Self.cache
		let key = CacheKey(self)
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
		let key: Font
		
		init(_ key: Font) { self.key = key }
		
		override var hash: Int { return key.hashValue }
		
		override func isEqual(_ object: Any?) -> Bool {
			guard let value = object as? CacheKey else { return false }
			return value.key == key
		}
	}
}
