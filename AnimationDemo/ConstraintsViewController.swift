//
//  ConstraintsViewController.swift
//  AnimationDemo
//
//  Created by Savvy Apps on 12/23/16.
//  Copyright © 2016 Savvy Apps. All rights reserved.
//

import UIKit

class ConstraintsViewController: UIViewController {
	
	enum State {
		case collapsed, expanded
		
		var other: State {
			switch self {
			case .collapsed: return .expanded
			case .expanded: return .collapsed
			}
		}
	}
	
	@IBOutlet weak var widthConstraint: NSLayoutConstraint!
	
	var state = State.collapsed {
		didSet {
			switch state {
			case .collapsed: widthConstraint.constant = 30
			case .expanded: widthConstraint.constant = 200
			}
			
			view.layoutIfNeeded()
		}
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
