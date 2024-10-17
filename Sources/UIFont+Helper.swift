//
//  UIFont+Helper.swift
//  AveFontHelpers
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension UIFont {
	var systemSerif: UIFont { withSystemDesign(.serif) }
	var systemRounded: UIFont { withSystemDesign(.rounded) }
	var bold: UIFont { withSymbolicTraits(.traitBold) }
	var italic: UIFont {withSymbolicTraits(.traitItalic) }
	var heavy: UIFont { withWeight(.heavy) }
	var black: UIFont { withWeight(.black) }
	var semibold: UIFont { withWeight(.semibold) }

	static func preferredFont(forTextStyle textStyle: UIFont.TextStyle, contentSizeCategory: UIContentSizeCategory) -> UIFont {
		var font: UIFont? = nil
		UITraitCollection(traitsFrom: [.current, UITraitCollection(preferredContentSizeCategory: .large)]).performAsCurrent {
			font = UIFont.preferredFont(forTextStyle: textStyle, compatibleWith: .current)
		}

		return font ?? UIFont.preferredFont(forTextStyle: textStyle)
	}

	func withTextStyle(_ textStyle: UIFont.TextStyle) -> UIFont {
		let metrics = UIFontMetrics(forTextStyle: textStyle)
		return metrics.scaledFont(for: self)
	}

	func withScaledSize(_ fontSize: CGFloat) -> UIFont {
		let metrics = UIFontMetrics.default
		return metrics.scaledFont(for: withSize(fontSize))
	}

	func withSystemDesign(_ design: UIFontDescriptor.SystemDesign) -> UIFont {
		return withFontDescriptor(fontDescriptor.withDesign(design))
	}

	func withSymbolicTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
		return withFontDescriptor(fontDescriptor.withSymbolicTraits(traits))
	}

	func withFontDescriptor(_ descriptor: UIFontDescriptor?) -> UIFont {
		return UIFont(descriptor: descriptor ?? fontDescriptor, size: pointSize)
	}

	func withWeight(_ weight: UIFont.Weight) -> UIFont {
		withAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
	}
	
	func withAttributes(_ attributes: [UIFontDescriptor.AttributeName: Any]) -> UIFont {
		return withFontDescriptor(fontDescriptor.addingAttributes(attributes))
	}
	
	func withFeatureSettings(_ settings: [(Int, Int)]) -> UIFont {
		guard settings.isEmpty == false else { return self }
		
		if #available(iOS 15, *) {
			let settingsList = settings.map { [UIFontDescriptor.FeatureKey.type: $0.0, UIFontDescriptor.FeatureKey.selector: $0.1] }
			return withAttributes([UIFontDescriptor.AttributeName.featureSettings: settingsList])
		} else {
			let settingsList = settings.map { [UIFontDescriptor.FeatureKey.featureIdentifier: $0.0, UIFontDescriptor.FeatureKey.typeIdentifier: $0.1] }
			return withAttributes([UIFontDescriptor.AttributeName.featureSettings: settingsList])
		}
	}
	
	func withAlternateStyle(_ style: Int) -> UIFont {
		return withFeatureSettings([(kStylisticAlternativesType, kStylisticAltOneOnSelector)])
	}
	
	var monospacedNumbers: UIFont { withFeatureSettings([(kNumberSpacingType, kMonospacedNumbersSelector)]) }
	
	var sfStraightSidesSixAndNine: UIFont { withAlternateStyle(kStylisticAltOneOnSelector) }
	var sfOpenFour: UIFont { withAlternateStyle(kStylisticAltTwoOnSelector) }
	var sfVerticallyAlignedColon: UIFont { withAlternateStyle(kStylisticAltThreeOnSelector) }
	var sfOpenCurrencies: UIFont { withAlternateStyle(kStylisticAltFourOnSelector) }
	var sfHighLegibility: UIFont { withAlternateStyle(kStylisticAltSixOnSelector) }
	var sfOneStoreyA: UIFont { withAlternateStyle(kStylisticAltSevenOnSelector) }
	
	var textStyle: TextStyle? {
		guard let styleName = fontDescriptor.fontAttributes[.textStyle] as? String else { return nil }
		return TextStyle(rawValue: styleName)
	}

	var weight: Weight? {
		guard let weightNumber = traits[.weight] as? NSNumber else { return nil }
		let weightRawValue = CGFloat(weightNumber.doubleValue)
		let weight = UIFont.Weight(rawValue: weightRawValue)
		return weight
	}

	private var traits: [UIFontDescriptor.TraitKey: Any] {
		return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any] ?? [:]
	}
}

public extension UIFont {
	static func from(_ from: Font) -> UIFont { from.font() }
}
