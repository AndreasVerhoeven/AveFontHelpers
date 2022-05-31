//
//  Font+AdditionalProperties.swift
//  Demo
//
//  Created by Andreas Verhoeven on 31/05/2022.
//

import UIKit

public extension Font {
	/// defines the casing for numbers
	enum NumberCase: Hashable {
		/// numbers can extend beyond the baseline, regular style
		case lower
		/// numbers do not extend beyond the baseline, similar as upper case
		case upper
		
		internal var features: [(Int, Int)] {
			switch self {
				case .lower: return [(kNumberCaseType, kLowerCaseNumbersSelector)]
				case .upper: return [(kNumberCaseType, kUpperCaseNumbersSelector)]
			}
		}
	}
	
	/// defines the spacing for numbers
	enum NumberSpacing: Hashable {
		/// all numbers have fixed width. Useful for when animating numbers or lining up columns of numbers.
		case monospaced
		/// numbers are proportionally spaced, looks better in regular text.
		case proportional
		
		internal var features: [(Int, Int)] {
			switch self {
				case .monospaced: return [(kNumberSpacingType, kMonospacedNumbersSelector)]
				case .proportional: return [(kNumberSpacingType, kProportionalNumbersSelector)]
			}
		}
	}
	
	/// defines how fractions are displayed
	enum FractionStyle: Hashable {
		/// no special fraction formatting
		case disabled
		/// fractions are written diagonal  like (1/2)
		case diagonal
		/// fractions are written vertically
		case vertical
		
		internal var features: [(Int, Int)] {
			switch self {
				case .disabled: return [(kFractionsType, kNoFractionsSelector)]
				case .diagonal: return [(kFractionsType, kDiagonalFractionsSelector)]
				case .vertical: return [(kFractionsType, kVerticalFractionsSelector)]
			}
		}
	}
	
	/// defines which characters are replaced by small caps
	enum SmallCapsStyle: Hashable {
		case disabled
		case replaceUppercase
		case replaceLowercase
		case replaceAll
		
		internal var features: [(Int, Int)] {
			switch self {
				case .disabled: return [(kLowerCaseType, kDefaultLowerCaseSelector), (kUpperCaseType, kDefaultUpperCaseSelector)]
				case .replaceUppercase: return [(kUpperCaseType, kUpperCaseSmallCapsSelector)]
				case .replaceLowercase: return [(kLowerCaseType, kLowerCaseSmallCapsSelector)]
				case .replaceAll: return [(kLowerCaseType, kLowerCaseSmallCapsSelector), (kUpperCaseType, kUpperCaseSmallCapsSelector)]
			}
		}
	}
	
	/// defines alternate styles for san francisco
	struct AlternateStyle: RawRepresentable, OptionSet, Hashable {
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
		
		internal var features: [(Int, Int)] {
			guard self != .none else { return [] }
			var features = [(Int, Int)]()
			for index in 1...20 where contains(Self(rawValue: 1 << index)) {
				features.append((kStylisticAlternativesType, index * 2))
			}
			return features
		}
	}
}

extension UIFontDescriptor.SymbolicTraits: Hashable {}
