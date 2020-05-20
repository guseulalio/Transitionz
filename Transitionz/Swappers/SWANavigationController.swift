//
//  TraNavigationController.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class SWANavigationController: UINavigationController, UINavigationControllerDelegate
{
	var transitionController = SWATransitionController.main
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		delegate = transitionController
		
		transitionController.regularAnimationType = ["pushAndFade.forward", "pushAndFade.backward", "slide.up", "slide.down", "slide.inFrom.topRight", "slide.inFrom.bottomRight", "slide.inFrom.bottomLeft", "slide.inFrom.topLeft"].randomElement()
    }
	
	// TODO: - Remove this. This method should be overriden by whoever subclasses this navigation controller
//	override func pushViewController(_ viewController: UIViewController, animated: Bool)
//	{
//		let differentTransitionProbability = Int.random(in: 0...100)
//
//		if differentTransitionProbability < 33
//		{
//			transitionController.nextAnimationType = ["pushAndFade.forward", "pushAndFade.backward", "slide.up", "slide.down", "slide.inFrom.topRight", "slide.inFrom.bottomRight", "slide.inFrom.bottomLeft", "slide.inFrom.topLeft"].randomElement()
//		}
//		super.pushViewController(viewController, animated: animated)
//	}
}
