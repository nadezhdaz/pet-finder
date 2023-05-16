 //
//  HomeViewController.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//  
//

import UIKit
import Foundation

class HomeViewController: ViewControllerBase<HomeViewModel> {
	private let container: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}()

	// MARK: - Create subviews
	private func addSubviews() {
		view.addSubview(container)
	}

	// MARK: create layout
	private func createLayout() {
		let padding = Semantic.size.app.defaultPadding
		let guide = view.safeAreaLayoutGuide
		let margins = view.layoutMarginsGuide
		NSLayoutConstraint.useAndActivate([
			container.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1),
			container.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: padding),
			container.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -padding),
			container.bottomAnchor.constraint(equalToSystemSpacingBelow: guide.bottomAnchor, multiplier: 1),
		])
	}

	// MARK: - LifeCycle
	override func loadView() {
		super.loadView()
		view.backgroundColor = Semantic.color.app.background
		addSubviews()
		createLayout()
	}
}

// MARK: - Localization
private extension String {
//	static let someText = NSLocalizedString("sampleKey", comment: "sampleComment")
}
