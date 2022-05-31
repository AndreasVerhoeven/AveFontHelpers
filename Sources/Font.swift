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
	
	/// which number case to use
	public var numberCase: NumberCase? = nil
	
	/// which number spacing to use
	public var numberSpacing: NumberSpacing? = nil
	
	/// which fraction style to use
	public var fractionStyle: FractionStyle? = nil
	
	/// which small caps style to use
	public var smallCapsStyle: SmallCapsStyle? = nil
	
	/// which alternate styles to use
	public var alternateStyles = AlternateStyle.none
}

public extension Font {
	private func with<T>(value: T? = nil, for keyPath: WritableKeyPath<Font, T>) -> Self {
		guard let value = value else { return self }
		var item = self
		item[keyPath: keyPath] = value
		return item
	}
	
	private func with<T>(nullableValue value: T? = nil, for keyPath: WritableKeyPath<Font, T?>) -> Self {
		var item = self
		item[keyPath: keyPath] = value
		return item
	}

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

	func with(size: CGFloat?) -> Self { with(value: size, for: \.size) }
	func with(weight: UIFont.Weight?) -> Self { with(value: weight, for: \.weight) }
	func with(design: UIFontDescriptor.SystemDesign?) -> Self { with(value: design, for: \.design) }
	func with(scalability: Scalability?) -> Self { with(value: scalability, for: \.scalability) }
	func with(traits: UIFontDescriptor.SymbolicTraits?) -> Self { with(value: traits, for: \.traits) }
	func with(kerning: CGFloat? = nil) -> Self { with(nullableValue: kerning, for: \.kerning) }

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
	
	func with(numberCase: NumberCase? = nil) -> Self { with(nullableValue: numberCase, for: \.numberCase) }
	func with(numberSpacing: NumberSpacing? = nil) -> Self { with(nullableValue: numberSpacing, for: \.numberSpacing) }
	func with(fractionStyle: FractionStyle? = nil) -> Self { with(nullableValue: fractionStyle, for: \.fractionStyle) }
	func with(smallCapsStyle: SmallCapsStyle? = nil) -> Self { with(nullableValue: smallCapsStyle, for: \.smallCapsStyle) }
	func with(alternateStyles: AlternateStyle = .none) -> Self { with(value: alternateStyles, for: \.alternateStyles) }
	
	func adding(alternateStyles: AlternateStyle?) -> Self {
		guard let alternateStyles = alternateStyles else { return self }
		var item = self
		item.alternateStyles.formUnion(alternateStyles)
		return item
	}
	
	func removing(alternateStyles: AlternateStyle?) -> Self {
		guard let alternateStyles = alternateStyles else { return self }
		var item = self
		item.alternateStyles.subtract(alternateStyles)
		return item
	}
	
	var monospacedNumbers: Self { with(numberSpacing: .monospaced) }
	var proportionalSpacedNumbers: Self { with(numberSpacing: .proportional) }
	
	var sfStraightSidesSixAndNine: Self { adding(alternateStyles: .sf.straightSidesSixAndNine) }
	var sfOpenFour: Self { adding(alternateStyles: .sf.openFour) }
	var sfVerticallyAlignedColon: Self { adding(alternateStyles: .sf.verticallyAlignedColon) }
	var sfOpenCurrencies: Self { adding(alternateStyles: .sf.openFour) }
	var sfHighLegibility: Self { adding(alternateStyles: .sf.highLegibility) }
	var sfOneStoreyA: Self { adding(alternateStyles: .sf.oneStoreyA) }
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
		
		var features = alternateStyles.features
		numberCase.flatMap { features += $0.features }
		numberSpacing.flatMap { features += $0.features }
		fractionStyle.flatMap { features += $0.features }
		smallCapsStyle.flatMap { features += $0.features }
		font = font.withFeatureSettings(features)

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

public extension Font {
	/// defines the casing for numbers
	enum NumberCase {
		/// numbers can extend beyond the baseline, regular style
		case lower
		/// numbers do not extend beyond the baseline, similar as upper case
		case upper
		
		fileprivate var features: [(Int, Int)] {
			switch self {
				case .lower: return [(kNumberCaseType, kLowerCaseNumbersSelector)]
				case .upper: return [(kNumberCaseType, kUpperCaseNumbersSelector)]
			}
		}
	}
	
	/// defines the spacing for numbers
	enum NumberSpacing {
		/// all numbers have fixed width. Useful for when animating numbers or lining up columns of numbers.
		case monospaced
		/// numbers are proportionally spaced, looks better in regular text.
		case proportional
		
		fileprivate var features: [(Int, Int)] {
			switch self {
				case .monospaced: return [(kNumberSpacingType, kMonospacedNumbersSelector)]
				case .proportional: return [(kNumberSpacingType, kProportionalNumbersSelector)]
			}
		}
	}
	
	/// defines how fractions are displayed
	enum FractionStyle {
		/// no special fraction formatting
		case disabled
		/// fractions are written diagonal  like (1/2)
		case diagonal
		/// fractions are written vertically
		case vertical
		
		fileprivate var features: [(Int, Int)] {
			switch self {
				case .disabled: return [(kFractionsType, kNoFractionsSelector)]
				case .diagonal: return [(kFractionsType, kDiagonalFractionsSelector)]
				case .vertical: return [(kFractionsType, kVerticalFractionsSelector)]
			}
		}
	}
	
	/// defines which characters are replaced by small caps
	enum SmallCapsStyle {
		case disabled
		case replaceUppercase
		case replaceLowercase
		case replaceAll
		
		fileprivate var features: [(Int, Int)] {
			switch self {
				case .disabled: return [(kLowerCaseType, kDefaultLowerCaseSelector), (kUpperCaseType, kDefaultUpperCaseSelector)]
				case .replaceUppercase: return [(kUpperCaseType, kUpperCaseSmallCapsSelector)]
				case .replaceLowercase: return [(kLowerCaseType, kLowerCaseSmallCapsSelector)]
				case .replaceAll: return [(kLowerCaseType, kLowerCaseSmallCapsSelector), (kUpperCaseType, kUpperCaseSmallCapsSelector)]
			}
		}
	}

	/// defines alternate styles for san francisco
	struct AlternateStyle: RawRepresentable, OptionSet {
		public var rawValue: Int
		
		public init(rawValue: Int) {
			self.rawValue = rawValue
		}
		
		public static let none = Self(rawValue: 0 << 0)
		public static let one = Self(rawValue: 1 << 1)
		public static let two = Self(rawValue: 1 << 2)
		public static let three = Self(rawValue: 1 << 3)
		public static let four = Self(rawValue: 1 << 4)
		public static let five = Self(rawValue: 1 << 5)
		public static let six = Self(rawValue: 1 << 6)
		public static let seven = Self(rawValue: 1 << 7)
		public static let eight = Self(rawValue: 1 << 8)
		public static let nine = Self(rawValue: 1 << 9)
		public static let ten = Self(rawValue: 1 << 10)
		public static let eleven = Self(rawValue: 1 << 11)
		public static let twelve = Self(rawValue: 1 << 12)
		public static let thirteen = Self(rawValue: 1 << 13)
		public static let fourteen = Self(rawValue: 1 << 14)
		public static let fifteen = Self(rawValue: 1 << 15)
		public static let sixteen = Self(rawValue: 1 << 16)
		public static let seventeen = Self(rawValue: 1 << 17)
		public static let eighteen = Self(rawValue: 1 << 18)
		public static let nineteen = Self(rawValue: 1 << 19)
		public static let twenty = Self(rawValue: 1 << 20)
		
		public enum sanFransisco {
			public static let straightSidesSixAndNine = AlternateStyle.one
			public static let openFour = AlternateStyle.two
			public static let verticallyAlignedColon = AlternateStyle.three
			public static let openCurrencies = AlternateStyle.four
			public static let highLegibility = AlternateStyle.six
			public static let oneStoreyA = AlternateStyle.seven
			
			// also in the font, but unknown:
			// public static let calculator = AlternateStyle.?
			// public static let circleSymbols = AlternateStyle.?
			// public static let circleSymbols = AlternateStyle.?
			// public static let squareSymbols = AlternateStyle.?
			// public static let filledSymbols = AlternateStyle.?
			// public static let smallSymbols = AlternateStyle.?
			// public static let largeSymbols = AlternateStyle.?
			// public static let lowercaseAlignment = AlternateStyle.?
		}
		public typealias sf = sanFransisco
		
		fileprivate var features: [(Int, Int)] {
			guard self != .none else { return [] }
			var features = [(Int, Int)]()
			for index in 1...20 where contains(Self(rawValue: 1 << index)) {
				features.append((kStylisticAlternativesType, index * 2))
			}
			return features
		}
	}
}
