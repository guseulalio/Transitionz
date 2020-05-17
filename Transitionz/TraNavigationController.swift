//
//  TraNavigationController.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class TraNavigationController: UINavigationController, UINavigationControllerDelegate
{
	var transitionController: TraTransitionController?
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		transitionController = TraTransitionController()
		delegate = transitionController
		
		transitionController?.regularAnimationType = "pushAndFade.forward"
			//["slide.up", "slide.down", "slide.inFrom.topRight", "slide.inFrom.bottomRight", "slide.inFrom.bottomLeft", "slide.inFrom.topLeft"].randomElement()
    }
}
