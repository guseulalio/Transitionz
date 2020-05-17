//
//  Screen2Controller.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class Screen2Controller: UIViewController
{
	var controller: UINavigationController?
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		view.backgroundColor = .systemTeal
		
		let button = UIButton()
		let buttonTitle = NSAttributedString(string: "Screen 2", attributes: [.font: UIFont.systemFont(ofSize: 64, weight: .heavy)])
		button.setAttributedTitle(buttonTitle, for: .normal)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		
		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			button.widthAnchor.constraint(equalTo: view.widthAnchor),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
	
	@objc func buttonTapped(_ sender: Any?)
	{
		let screen1 = Screen1Controller()
		screen1.controller = controller
		controller?.pushViewController(screen1, animated: true)
	}
}
