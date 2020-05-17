//
//  TraNavigationController.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class VerticalSlideTransition: NSObject, UIViewControllerAnimatedTransitioning
{
	var duration: TimeInterval
	var upwards: Bool
	
	init(duration: TimeInterval, upwards: Bool)
	{
		self.duration = duration
		self.upwards = upwards
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
	{
		let container = transitionContext.containerView
		
		guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
		guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
		
		if upwards
		{
			container.addSubview(toView)
			
			toView.frame = CGRect(x: 0, y: fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			
			UIView.animate(withDuration: duration, animations: {
				toView.frame = fromView.frame
				fromView.frame = CGRect(x: 0, y: -fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			}, completion: { (finished) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
		} else { // downwards
			
			container.insertSubview(toView, belowSubview: fromView)
			
			toView.frame = CGRect(x: 0, y: -fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			
			UIView.animate(withDuration: duration, animations: {
				toView.frame = fromView.frame
				fromView.frame = CGRect(x: 0, y: fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
			}, completion: { (finished) in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
		}
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
	{ return duration }
}
