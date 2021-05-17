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
		let newDescriptor = fontDescriptor.addingAttributes([
			.traits: [UIFontDescriptor.TraitKey.weight: weight]
		])
		return withFontDescriptor(newDescriptor)
	}

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
