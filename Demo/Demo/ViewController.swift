//
//  ViewController.swift
//  Demo
//
//  Created by Andreas Verhoeven on 16/05/2021.
//

import UIKit

extension Font {
	static let title = Font(style: .largeTitle, weight: .thin)
	static let subTitle = Font(size: 22, style: .headline, name: "Marker Felt")
	static let giantNumber = Font(size: 44, maximumSize: 46, weight: .black, design: .rounded)
}

class ViewController: UIViewController {
	var offsetIndexPath: IndexPath?

	lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.spacing = 8
		stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		stackView.frame = CGRect(origin: .zero, size: view.bounds.size)
		view.addSubview(stackView)
		return stackView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		let titleLabel = UILabel(text: "Large Title", font: .ios.largeTitle.rounded, color: .label, alignment: .center)
		stackView.addArrangedSubview(titleLabel)

		let subTitle = UILabel(text: "A Sub Title", font: .subTitle, color: .label, alignment: .center)
		stackView.addArrangedSubview(subTitle)

		let roundedLabel = UILabel(text: "9.622,34", font: .giantNumber, color: .label, alignment: .center)
		stackView.addArrangedSubview(roundedLabel)
		
		let roundedMonospacedLabel = UILabel(text: "9.622,34", font: .giantNumber.monospacedNumbers.sfStraightSidesSixAndNine.sfOpenFour, color: .label, alignment: .center)
		stackView.addArrangedSubview(roundedMonospacedLabel)

		let bodyText = String(repeating: "Body text goes here. ", count: 4)
		let bodyTextView = UITextView(text: bodyText, font: .ios.body.smaller.bold, color: .secondaryLabel, alignment: .center)
		bodyTextView.isScrollEnabled = false
		stackView.addArrangedSubview(bodyTextView)
		
		let text = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ:_/+-*$%@# ½ × ①"
		let bodyTextViewRegular = UITextView(text: text, font: .ios.body, color: .label, alignment: .center)
		bodyTextViewRegular.isScrollEnabled = false
		stackView.addArrangedSubview(bodyTextViewRegular)
		
		let bodyTextViewAlternative = UITextView(text: text, font: .ios.body.with(alternateStyles: [.sf.oneStoreyA, .sf.highLegibility, .sf.openCurrencies, .sf.verticallyAlignedColon]), color: .label, alignment: .center)
		bodyTextViewAlternative.isScrollEnabled = false
		stackView.addArrangedSubview(bodyTextViewAlternative)
		
		// spacer
		stackView.addArrangedSubview(UIView())
	}
}
