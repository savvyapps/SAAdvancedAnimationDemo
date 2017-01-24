//
//  TransformViewController.swift
//  AnimationDemo
//
//  Created by Savvy Apps on 12/23/16.
//  Copyright © 2016 Savvy Apps. All rights reserved.
//

import UIKit

class TransformViewController: UIViewController {
	enum State {
		case collapsed, expanded
		
		var other: State {
			switch self {
			case .collapsed: return .expanded
			case .expanded: return .collapsed
			}
		}
	}
	
	@IBOutlet weak var imageView: UIImageView!
	
	var state = State.collapsed {
		didSet {
			switch state {
			case .collapsed: imageView.transform = CGAffineTransform(translationX: 0, y: -imageView.frame.height)
			case .expanded: imageView.transform = .identity
			}
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		state = (state)
	}
	
	func setState(_ state: State, animated: Bool) {
		UIView.animate(withDuration: animated ? 0.25 : 0) {
			self.state = state
		}
	}
	
	@IBAction func animate() {
		setState(state.other, animated: true)
	}
}
