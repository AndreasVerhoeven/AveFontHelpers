//
//  UIKit+FontHelpers.swift
//  AveFontHelpers
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension UILabel {
	convenience init(text: String? = nil, font: Font, color: UIColor? = nil, alignment: NSTextAlignment = .natural, numberOfLines: Int = 0) {
		self.init()
		self.font = .from(font)
		color.map { self.textColor = $0 }
		self.textAlignment = alignment
		self.numberOfLines = numberOfLines
		self.adjustsFontForContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
		self.text = text
	}
}

extension UITextView {
	public convenience init(text: String? = nil, font: Font, color: UIColor? = nil, alignment: NSTextAlignment = .natural, isScrollEnabled: Bool = false) {
		self.init()
		self.font = .from(font)
		color.map { self.textColor = $0 }
		self.textAlignment = alignment
		self.adjustsFontForContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
		self.text = text
	}
}

extension UIButton {
	public convenience init(title: String? = nil, font: Font, type: UIButton.ButtonType) {
		self.init(type: type)
		self.setTitle(title, for: .normal)
		self.titleLabel?.font = .from(font)
		self.titleLabel?.adjustsFontForContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
		self.adjustsImageSizeForAccessibilityContentSizeCategory = font.shouldAdjustsFontForContentSizeCategory
	}
}
