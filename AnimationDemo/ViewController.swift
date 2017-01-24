//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Savvy Apps on 11/23/16.
//  Copyright © 2016 Savvy Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var expandedLayoutContainer: UIView!
	@IBOutlet weak var collapsedLayoutContainer: UIView!
	
	@IBOutlet weak var artImageView: UIImageView!
	@IBOutlet weak var expandedArtReference: UIView!
	@IBOutlet weak var collapsedArtReference: UIView!
	
	var progress: CGFloat = .collapsed {
		didSet {
			applyState()
		}
	}
	
	func setProgresss(_ progress: CGFloat, animated: Bool) {
		guard animated else {
			self.progress = progress
			return
		}
		
		UIView.animate(withDuration: 1) { self.progress = progress }
	}
	
	private func applyState() {
		//	We need to convert the frames of our reference views to the coordinates of our view
		let compactFrame = view.convert(collapsedArtReference.bounds, from: collapsedArtReference)
		let expandedFrame = view.convert(expandedArtReference.bounds, from: expandedArtReference)
		
		let finalFrame = lerp(start: compactFrame, end: expandedFrame, progress: progress)
		
		artImageView.frame = finalFrame
		
		expandedLayoutContainer.alpha = progress
		collapsedLayoutContainer.alpha = 1 - progress
	}
	
	var storedSize: CGSize?
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		guard view.bounds.size != storedSize else { return }
		storedSize = view.bounds.size
		
		applyState()
	}
	
	@IBAction func animate() {
		setProgresss(progress > 0.5 ? .collapsed : .expanded, animated: true)
	}
	
}

extension CGFloat {
	static let collapsed: CGFloat = 0.0
	static let expanded: CGFloat = 1.0
}

//	You can find all these lerp functions and more in the CGMathSwift pod

func lerp(start: CGFloat, end: CGFloat, progress: CGFloat) -> CGFloat {
	return (1 - progress) * start + progress * end
}

func lerp(start: CGPoint, end: CGPoint, progress: CGFloat) -> CGPoint {
	return CGPoint(x: lerp(start: start.x, end: end.x, progress: progress),
	               y: lerp(start: start.y, end: end.y, progress: progress))
}

func lerp(start: CGSize, end: CGSize, progress: CGFloat) -> CGSize {
	return CGSize(width: lerp(start: start.width, end: end.width, progress: progress),
	              height: lerp(start: start.height, end: end.height, progress: progress))
}

func lerp(start: CGRect, end: CGRect, progress: CGFloat) -> CGRect {
	let origin = lerp(start: start.origin, end: end.origin, progress: progress)
	let size = lerp(start: start.size, end: end.size, progress: progress)
	return CGRect(origin: origin, size: size)
}
