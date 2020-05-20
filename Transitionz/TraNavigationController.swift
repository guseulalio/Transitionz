//
//  TraNavigationController.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 20/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class TraNavigationController: SWANavigationController
{
	var nextTransition: String?
	{
		get { transitionController.nextAnimationType }
		set { transitionController.nextAnimationType = newValue }
	}
}
