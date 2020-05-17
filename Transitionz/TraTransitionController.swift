//
//  TraTransitionController.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class TraTransitionController: NSObject, UINavigationControllerDelegate
{
	var regularAnimationType: String? = nil
		{ didSet { nextAnimationType = regularAnimationType } }
	var nextAnimationType: String? = nil
	var opposites: [String?: String?]
	var history = [String?]()
	
	
	override init()
	{
		opposites = [
			nil: nil,
			"slide.up": "slide.down",
			"slide.down": "slide.up",
			"slide.inFrom.topRight": "slide.outTo.topRight",
			"slide.outTo.topRight": "slide.inFrom.topRight",
			"slide.inFrom.bottomRight": "slide.outTo.bottomRight",
			"slide.outTo.bottomRight": "slide.inFrom.bottomRight",
			"slide.inFrom.bottomLeft": "slide.outTo.bottomLeft",
			"slide.outTo.bottomLeft": "slide.inFrom.bottomLeft",
			"slide.inFrom.topLeft": "slide.outTo.topLeft",
			"slide.outTo.topLeft": "slide.inFrom.topLeft",
			"pushAndFade.forward": "pushAndFade.backward",
			"pushAndFade.backward": "pushAndFade.forward"
		]
		super.init()
	}
	
	func getNextAnimation() -> UIViewControllerAnimatedTransitioning?
	{
		var next: UIViewControllerAnimatedTransitioning?
		
		switch nextAnimationType
		{
		case "slide.up": next = VerticalSlideTransition(duration: TimeInterval(0.3), upwards: true)
		case "slide.down": next = VerticalSlideTransition(duration: TimeInterval(0.3), upwards: false)
		case "slide.inFrom.topRight": next = DiagonalSlideTransition(duration: 0.3, movement: (.inFrom, .topRight))
		case "slide.outTo.topRight": next = DiagonalSlideTransition(duration: 0.3, movement: (.outTo, .topRight))
		case "slide.inFrom.bottomRight": next = DiagonalSlideTransition(duration: 0.3, movement: (.inFrom, .bottomRight))
		case "slide.outTo.bottomRight": next = DiagonalSlideTransition(duration: 0.3, movement: (.outTo, .bottomRight))
		case "slide.inFrom.bottomLeft": next = DiagonalSlideTransition(duration: 0.3, movement: (.inFrom, .bottomLeft))
		case "slide.outTo.bottomLeft": next = DiagonalSlideTransition(duration: 0.3, movement: (.outTo, .bottomLeft))
		case "slide.inFrom.topLeft": next = DiagonalSlideTransition(duration: 0.3, movement: (.inFrom, .topLeft))
		case "slide.outTo.topLeft": next = DiagonalSlideTransition(duration: 0.3, movement: (.outTo, .topLeft))
		case "pushAndFade.forward": next = PushAndFadeTransition(duration: 0.3, moveForward: true)
		case "pushAndFade.backward": next = PushAndFadeTransition(duration: 0.3, moveForward: false)
		default: next = nil
		}
		
		return next
	}
	
	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
	{
		let animation: UIViewControllerAnimatedTransitioning?
		switch operation
		{
		case .push:
			history.append(opposites[nextAnimationType] ?? nil)
			animation = getNextAnimation()
		default:
			nextAnimationType = history.removeLast()
			animation = getNextAnimation()
		}
		
		nextAnimationType = "pushAndFade.forward" //["slide.up", "slide.down", "slide.inFrom.topRight", "slide.inFrom.bottomRight", "slide.inFrom.bottomLeft", "slide.inFrom.topLeft"].randomElement()
		//nextAnimationType = regularAnimationType
		return animation
	}
}
