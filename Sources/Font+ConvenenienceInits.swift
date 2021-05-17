//
//  Font+ConvenenienceInits.swift
//  AveFontHelpers
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension Font {
	static func fixed(size: CGFloat, weight: UIFont.Weight? = nil, design: UIFontDescriptor.SystemDesign? = nil) -> Font {
		return Font(size: size, weight: weight, design: design, scalability: .fixed)
	}
}
