//
//  DiagonalSlideAnimation.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class SWADiagonalSlideTransition: NSObject, UIViewControllerAnimatedTransitioning
{
	enum Direction { case inFrom, outTo }
	
	enum Corner { case topRight, bottomRight, bottomLeft, topLeft }
	
	var duration: TimeInterval
	var direction: Direction
	var corner: Corner
	
	init(duration: TimeInterval, movement: (direction: Direction, corner: Corner))
	{
		self.duration = duration
		self.direction = movement.direction
		self.corner = movement.corner
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
	{
		let container = transitionContext.containerView
		
		guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
		guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
		
		switch direction
		{
		case .inFrom:
			container.addSubview(toView)
			
			switch corner
			{
			case .topRight: toView.frame = CGRect(x: fromView.frame.width, y: -fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			case .bottomRight: toView.frame = CGRect(x: fromView.frame.width, y: fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			case .bottomLeft: toView.frame = CGRect(x: -fromView.frame.width, y: fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			case .topLeft: toView.frame = CGRect(x: -fromView.frame.width, y: -fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			}
			
			UIView.animate(withDuration: duration, animations: {
				toView.frame = fromView.frame
			}, completion: { (finished) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
		default: // outTo
			container.insertSubview(toView, belowSubview: fromView)
			toView.frame = fromView.frame
			
			UIView.animate(withDuration: duration, animations:
			{ [weak self] in
				switch self?.corner
				{
				case .topRight: fromView.frame = CGRect(x: fromView.frame.width, y: -fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
				case .bottomRight: fromView.frame = CGRect(x: fromView.frame.width, y: fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
				case .bottomLeft: fromView.frame = CGRect(x: -fromView.frame.width, y: fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
				case .topLeft: fromView.frame = CGRect(x: -fromView.frame.width, y: -fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
				case .none:
					return
				}
			}, completion: { (finished) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
		}
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
	{ return duration }
}
