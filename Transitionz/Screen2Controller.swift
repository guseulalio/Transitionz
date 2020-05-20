//
//  Screen2Controller.swift
//  Transitionz
//
//  Created by Gustavo E M Cabral on 17/5/20.
//  Copyright © 2020 Gustavo Eulalio. All rights reserved.
//

import UIKit

class Screen2Controller: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
	var controller: TraNavigationController?
	let picker = UIPickerView()
	
	var transitionDescriptions: [String] = ["slide.up", "slide.down", "slide.inFrom.topRight", "slide.outTo.topRight", "slide.inFrom.bottomRight", "slide.outTo.bottomRight", "slide.inFrom.bottomLeft", "slide.outTo.bottomLeft", "slide.inFrom.topLeft", "slide.outTo.topLeft", "pushAndFade.forward", "pushAndFade.backward"]
	var currentTransition = 0
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		view.backgroundColor = .systemTeal
		
		let label = UILabel()
		label.text = "Screen B"
		label.font = UIFont.systemFont(ofSize: 48, weight: .heavy)
		label.textAlignment = .center
		
		picker.dataSource = self
		picker.delegate = self
		
		let button = UIButton()
		let buttonTitle = NSAttributedString(string: "Go", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
		button.setAttributedTitle(buttonTitle, for: .normal)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		
		view.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(picker)
		picker.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
			label.widthAnchor.constraint(equalTo: view.widthAnchor),
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			picker.widthAnchor.constraint(equalTo: view.widthAnchor),
			picker.heightAnchor.constraint(equalToConstant: 200),
			picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			picker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			
			
			button.widthAnchor.constraint(equalTo: view.widthAnchor),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
		])
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		picker.selectRow(currentTransition, inComponent: 0, animated: false)
	}
	
	@objc func buttonTapped(_ sender: Any?)
	{
		let screen1 = Screen1Controller()
		screen1.controller = controller
		screen1.currentTransition = currentTransition
		controller?.nextTransition = transitionDescriptions[currentTransition]
		controller?.pushViewController(screen1, animated: true)
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		transitionDescriptions.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return transitionDescriptions[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		currentTransition = row
	}
}
