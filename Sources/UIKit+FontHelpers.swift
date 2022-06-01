//
//  UIKit+FontHelpers.swift
//  AveFontHelpers
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public protocol AveViewFontInitable {
	func setCustomFont(_ font: Font)
}

public extension UILabel {
	convenience init(text: String? = nil, font: Font, color: UIColor? = nil, alignment: NSTextAlignment = .natural, numberOfLines: Int = 0) {
		self.init()
		self.font = .from(font)
		color.map { self.textColor = $0 }
		self.textAlignment = alignment
		self.numberOfLines = numberOfLines
		self.adjustsFontForContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
		self.text = text
		
		if let settable = self as? AveViewFontInitable {
			settable.setCustomFont(font)
		}
	}
}

public extension UITextView {
	convenience init(text: String? = nil, font: Font, color: UIColor? = nil, alignment: NSTextAlignment = .natural, isScrollEnabled: Bool = false) {
		self.init()
		self.font = .from(font)
		color.map { self.textColor = $0 }
		self.textAlignment = alignment
		self.adjustsFontForContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
		self.text = text
		
		if let settable = self as? AveViewFontInitable {
			settable.setCustomFont(font)
		}
	}
}

public extension UIButton {
	convenience init(title: String? = nil, font: Font, type: UIButton.ButtonType) {
		self.init(type: type)
		self.setTitle(title, for: .normal)
		self.titleLabel?.font = .from(font)
		self.titleLabel?.adjustsFontForContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
		self.adjustsImageSizeForAccessibilityContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
		
		if let settable = self as? AveViewFontInitable {
			settable.setCustomFont(font)
		}
	}
}
