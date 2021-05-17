//
//  Font.swift
//  AveFontHelpers
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

/// A structure that describes a font
public struct Font: Equatable {
	public init(size: CGFloat = 0, maximumSize: CGFloat? = nil, style: UIFont.TextStyle? = nil, weight: UIFont.Weight? = nil, design: UIFontDescriptor.SystemDesign? = nil, traits: UIFontDescriptor.SymbolicTraits? = nil, scalability: Font.Scalability = .scalable, name: String? = nil, kerning: CGFloat? = nil, lineHeight: CGFloat? = nil) {
		self.size = size
		self.maximumSize = maximumSize
		self.style = style
		self.weight = weight
		self.design = design
		self.traits = traits
		self.scalability = scalability
		self.name = name
		self.kerning = kerning
		self.lineHeight = lineHeight
	}

	/// The size of this font, in points
	public var size: CGFloat = 0

	/// **optional** the maximum size of this font, in points.
	public var maximumSize: CGFloat? = nil

	/// the textStyle this font is based on. If size == 0, we'll use this text style as the font
	public var style: UIFont.TextStyle? = nil

	/// the weight of our font
	public var weight: UIFont.Weight? = nil

	/// the design of our font
	public var design: UIFontDescriptor.SystemDesign? = nil

	/// custom traits for our font
	public var traits: UIFontDescriptor.SymbolicTraits? = nil

	/// how the font should scale
	public var scalability: Scalability = .scalable

	/// the name of the font
	public var name: String? = nil

	/// custom kerning for the font
	public var kerning: CGFloat? = nil

	/// custom line height for the font
	public var lineHeight: CGFloat? = nil

	public enum Scalability {
		/// the font is just a placeholder that should not scale
		case placeholder

		/// this font is scalable with dynamic type
		case scalable

		/// this font is unscalable
		case fixed
	}
}

public extension Font {

	func smaller(by: CGFloat) -> Self {
		return with(size: size - by)
	}

	func larger(by: CGFloat) -> Self {
		return with(size: size + by)
	}

	var smaller: Self {
		return smaller(by: 1)
	}

	var larger: Self {
		return larger(by: 1)
	}

	func with(size: CGFloat?) -> Self {
		guard let size = size else {return self}
		var item = self
		item.size = size
		return item
	}

	func with(weight: UIFont.Weight?) -> Self {
		guard let weight = weight else {return self}
		var item = self
		item.weight = weight
		return item
	}

	func with(design: UIFontDescriptor.SystemDesign?) -> Self {
		guard let design = design else {return self}
		var item = self
		item.design = design
		return item
	}

	func with(scalability: Scalability?) -> Self {
		guard let scalability = scalability else {return self}
		var item = self
		item.scalability = scalability
		return item
	}

	func with(traits: UIFontDescriptor.SymbolicTraits?) -> Self {
		guard let traits = traits else {return self}
		var item = self
		item.traits = traits
		return item
	}

	func with(kerning: CGFloat? = nil) -> Self {
		var item = self
		item.kerning = kerning
		return item
	}

	func adding(traits: UIFontDescriptor.SymbolicTraits?) -> Self {
		guard let traits = traits else {return self}
		var item = self
		var newTraits = item.traits ?? []
		newTraits.insert(traits)
		item.traits = newTraits
		return item
	}

	func increasing(with value: CGFloat?) -> Self {
		guard let value = value else { return self }
		return with(size: size + value)
	}

	var bolder: Self {
		if let weight = weight {
			return with(weight: weight.bolder())
		} else if traits?.contains(.traitBold) == true {
			return with(weight: .heavy)
		} else {
			return adding(traits: .traitBold)
		}
	}

	var rounded: Self {with(design: .rounded)}
	var serif: Self {with(design: .serif)}

	var ultraLight: Self {with(weight: .ultraLight)}
	var thin: Self {with(weight: .thin)}
	var light: Self {with(weight: .light)}
	var regular: Self {with(weight: .regular)}
	var medium: Self {with(weight: .medium)}
	var semibold: Self {with(weight: .semibold)}
	var bold: Self {with(weight: .bold)}
	var heavy: Self {with(weight: .heavy)}
	var black: Self {with(weight: .black)}

	var italic: Self {with(traits: .traitItalic)}

	var unkerned: Self {with(kerning: nil)}
	var fixed: Self { with(scalability: .fixed) }
}

public extension Font {
	func font() -> UIFont {
		var font: UIFont
		if let name = name {
			font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
		} else if size == 0, let style = style {
			font = UIFont.preferredFont(forTextStyle: style)
		} else {
			font = UIFont.systemFont(ofSize: size)
		}

		font = weight.map{font.withWeight($0)} ?? font
		font = design.map{font.withSystemDesign($0)} ?? font

		if let traits = traits {
			font = font.withFontDescriptor(font.fontDescriptor.withSymbolicTraits(font.fontDescriptor.symbolicTraits.union(traits)))
		}

		switch scalability {
			case .placeholder, .fixed:
				return font

			case .scalable:
				let metrics = style.map {UIFontMetrics(forTextStyle: $0)} ?? UIFontMetrics.default
				if let maximumSize = maximumSize {
					return metrics.scaledFont(for: font, maximumPointSize: maximumSize)
				} else {
					return metrics.scaledFont(for: font)
				}
		}
	}

	func additionalLineSpacing() -> CGFloat {
		guard let lineHeight = lineHeight else {return 0}
		let currentLineHeight = with(scalability: .fixed).font().lineHeight
		return max(0, lineHeight - currentLineHeight)
	}

	var shouldAdjustsFontForContentSizeCategory: Bool {
		switch scalability {
			case .placeholder, .fixed: return false
			case .scalable: return true
		}
	}
}

public extension UIFont {
	static func from(_ from: Font) -> UIFont { from.font() }
}
