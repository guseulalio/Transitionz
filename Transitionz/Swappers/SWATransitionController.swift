//
//  TraTransitionController.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

typealias SWATransitionClosure = (_: TimeInterval) -> UIViewControllerAnimatedTransitioning?

class SWATransitionController: NSObject, UINavigationControllerDelegate
{
	var regularAnimationType: String? = nil
		{ didSet { nextAnimationType = regularAnimationType } }
	var nextAnimationType: String? = nil
	var opposites: [String?: String?]
	var history = [String?]()
	
	var transitionList = [String? : SWATransitionClosure]()
	
	static private var mainTC: SWATransitionController!
	
	static var main: SWATransitionController
	{
		get
		{
			if mainTC == nil { mainTC = SWATransitionController() }
			return mainTC
		}
	}
	
	override init()
	{
		opposites = [ nil: nil ]
		super.init()
		
		register(
			transitionName: nil, for: { _ in return nil },
			oppositeName: nil, for: { _ in return nil })
		register(
			transitionName: "slide.up", for: { duration in return SWAVerticalSlideTransition(duration: duration, upwards: true) },
			oppositeName: "slide.down", for: { duration in return SWAVerticalSlideTransition(duration: duration, upwards: false) })
		register(
			transitionName: "slide.inFrom.topRight", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.inFrom, .topRight)) },
			oppositeName: "slide.outTo.topRight", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.outTo, .topRight)) })
		register(
			transitionName: "slide.inFrom.bottomRight", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.inFrom, .bottomRight)) },
			oppositeName: "slide.outTo.bottomRight", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.outTo, .bottomRight)) })
		register(
			transitionName: "slide.inFrom.bottomLeft", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.inFrom, .bottomLeft)) },
			oppositeName: "slide.outTo.bottomLeft", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.outTo, .bottomLeft)) })
		register(
			transitionName: "slide.inFrom.topLeft", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.inFrom, .topLeft)) },
			oppositeName: "slide.outTo.topLeft", for: { duration in return SWADiagonalSlideTransition(duration: duration, movement: (.outTo, .topLeft)) })
		register(
			transitionName: "pushAndFade.forward", for: { duration in return SWAPushAndFadeTransition(duration: duration, moveForward: true) },
			oppositeName: "pushAndFade.backward", for: { duration in return SWAPushAndFadeTransition(duration: duration, moveForward: false) })
	}
	
	func register(transitionName: String?, for transition: @escaping SWATransitionClosure,
				  oppositeName: String?, for reverseTransition: @escaping SWATransitionClosure)
	{
		transitionList[transitionName] = transition
		transitionList[oppositeName] = reverseTransition
		opposites[transitionName] = oppositeName
		opposites[oppositeName] = transitionName
	}
	
	func getNextAnimation() -> UIViewControllerAnimatedTransitioning?
	{
		var next: UIViewControllerAnimatedTransitioning?
		
		let function = transitionList[nextAnimationType]
		next = function == nil ? nil : function!(0.3)
		
		return next
	}
	
	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
	{
		if operation == .push {
			history.append(opposites[nextAnimationType] ?? nil)
		} else {
			nextAnimationType = history.removeLast()
		}
		
		let animation: UIViewControllerAnimatedTransitioning? = getNextAnimation()
		nextAnimationType = regularAnimationType
		
		return animation
	}
}
