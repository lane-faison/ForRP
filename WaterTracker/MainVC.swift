//
//  MainVC.swift
//  WaterTracker
//
//  Created by Ryan Phillips on 7/18/17.
//  Copyright © 2017 Ryan Phillips. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var amounts = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128]
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let waterView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let waterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Drip")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "WaterTracker"
        label.font = UIFont(name: "Avenir next", size: 30)
        label.textColor = ColorScheme.darkPrimaryColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountPicker: UIPickerView = {
        let picker = UIPickerView()
    
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 30
        button.layer.borderColor = ColorScheme.lightPrimaryColor.cgColor
        button.layer.borderWidth = 5
        button.backgroundColor = .white
        button.setTitle("Add", for: .normal)
        button.setTitleColor(ColorScheme.darkPrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir next", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set Weight", style: .plain, target: self, action: #selector(goToSetWeight))
    
        view.addSubview(backView)
        view.addSubview(titleLabel)
        view.addSubview(amountPicker)
        view.addSubview(addButton)
        
        amountPicker.delegate = self
        amountPicker.dataSource = self

        setupWaterFeature()
        displayWater()
        setupOptions()
    }
    
    func goToSetWeight(){
        performSegue(withIdentifier: "toSetWeight", sender: nil)
    }

    func setupWaterFeature() {
        backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        backView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        backView.addSubview(waterView)
        backView.addSubview(waterImageView)
        
        waterImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20).isActive = true
        waterImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        waterImageView.widthAnchor.constraint(equalTo: backView.widthAnchor, constant: -60).isActive = true
        waterImageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true

    }
    
    func displayWater() {
        waterView.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        waterView.widthAnchor.constraint(equalTo: waterImageView.widthAnchor).isActive = true
        waterView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10).isActive = true
        waterView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupOptions() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
  
        amountPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        amountPicker.heightAnchor.constraint(equalToConstant: 120).isActive = true
        amountPicker.widthAnchor.constraint(equalToConstant: 150).isActive = true
        amountPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.topAnchor.constraint(equalTo: amountPicker.bottomAnchor).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return amounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(amounts[row]) oz"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}

