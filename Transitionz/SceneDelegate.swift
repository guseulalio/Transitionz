//
//  SceneDelegate.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
	{
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let navController = TraNavigationController() //UINavigationController()
		
		let screen1 = Screen1Controller()
		screen1.controller = navController
		navController.pushViewController(screen1, animated: false)
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window!.windowScene = windowScene
		window!.rootViewController = navController
		window!.makeKeyAndVisible()
	}
}
