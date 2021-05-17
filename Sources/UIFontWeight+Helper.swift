//
//  UIFontWeight+Helper.swift
//  AveFontHelpers
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension UIFont.Weight {
	func bolder() -> UIFont.Weight {
		switch self {
			case .ultraLight: return .bold //.thin
			case .thin: return .bold //.light
			case .light: return .bold //.regular
			case .regular: return .bold //.medium
			case .medium: return .bold //.semibold
			case .semibold: return .bold
			case .bold: return .heavy
			case .heavy: return .black
			case .black: return UIFont.Weight(rawValue: rawValue + 1)
			default: return UIFont.Weight(rawValue: rawValue + 1)
		}
	}
}
