//
//  SymbolConfiguration.swift
//  Demo
//
//  Created by Andreas Verhoeven on 01/06/2022.
//

import UIKit

public extension UIImage.SymbolConfiguration {
	convenience init(font: Font) {
		self.init(font: font.font())
	}
}
