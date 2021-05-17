//
//  Font+TextStyles.swift
//  AveFontHelpers
//
//  Created by Andreas Verhoeven on 17/05/2021.
//

import UIKit

public extension Font {
	static var ios = iOS()

	// iOS text style fonts
	struct iOS {
		var largeTitle = Font(style: .largeTitle)
		var title1 = Font(style: .title1)
		var title2 = Font(style: .title2)
		var title3 = Font(style: .title3)
		var headline = Font(style: .headline)
		var subheadline = Font(style: .subheadline)
		var body = Font(style: .body)
		var callout = Font(style: .callout)
		var footnote = Font(style: .footnote)
		var caption1 = Font(style: .caption1)
		var caption2 = Font(style: .caption2)
	}
}
