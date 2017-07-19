//
//  WeightCalcViewController.swift
//  WaterTracker
//
//  Created by Ryan Phillips on 7/19/17.
//  Copyright © 2017 Ryan Phillips. All rights reserved.
//

import UIKit

class WeightCalcViewController: UIViewController {
    
    let weightText: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 5
        text.layer.borderColor = ColorScheme.lightPrimaryColor.cgColor
        text.layer.cornerRadius = 30
        text.font = UIFont(name: "Avenir next", size: 20)
        text.textAlignment = .center
        text.text = nil
        text.placeholder = "Enter Weight Here"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let describeText: UITextView = {
        let describe = UITextView()
        describe.font = UIFont(name: "Avenir next", size: 12)
        describe.textColor = .black
        describe.text = "Goal based on 2/3 of body weight converted into ounces"
        describe.textAlignment = .center
        describe.translatesAutoresizingMaskIntoConstraints = false
        return describe
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 30
        button.layer.borderColor = ColorScheme.lightPrimaryColor.cgColor
        button.layer.borderWidth = 5
        button.backgroundColor = .white
        button.setTitle("Save Goal", for: .normal)
        button.setTitleColor(ColorScheme.darkPrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir next", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(weightText)
        view.addSubview(describeText)
        view.addSubview(saveButton)
        
        
        displayWeightSection()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WeightCalcViewController.dismissKeyboard))
        
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func displayWeightSection() {
        
        weightText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightText.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        weightText.widthAnchor.constraint(equalToConstant: 230).isActive = true
        weightText.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        describeText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        describeText.topAnchor.constraint(equalTo: weightText.bottomAnchor).isActive = true
        describeText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        describeText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.topAnchor.constraint(equalTo: describeText.bottomAnchor, constant: 160).isActive = true
    }
    
    
    
}
