//
//  PushAndFadeTransition.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class SWAPushAndFadeTransition: NSObject, UIViewControllerAnimatedTransitioning
{
	var duration: TimeInterval
	var moveForward: Bool
	
	init(duration: TimeInterval, moveForward: Bool)
	{
		self.duration = duration
		self.moveForward = moveForward
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
	{
		let container = transitionContext.containerView
		
		guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
		guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
		
		if moveForward
		{
			container.insertSubview(toView, belowSubview: fromView)
			
			toView.frame = fromView.frame
			toView.alpha = 0
			toView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

			UIView.animate(withDuration: duration, animations: {
				toView.alpha = 1
				toView.transform = CGAffineTransform.identity
				
				fromView.alpha = 0
				fromView.transform = CGAffineTransform(scaleX: 2, y: 2)
			}, completion: { (finished) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
				fromView.transform = .identity
			})
		} else { // moveBackwards
			
			container.addSubview(toView)
			
			toView.frame = fromView.frame
			toView.alpha = 0
			toView.transform = CGAffineTransform(scaleX: 2, y: 2)
			
			UIView.animate(withDuration: duration, animations: {
				fromView.alpha = 0
				fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
				
				toView.alpha = 1
				toView.transform = CGAffineTransform.identity
			}, completion: { (finished) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
				fromView.transform = .identity
			})
		}
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
	{ return duration }
}
