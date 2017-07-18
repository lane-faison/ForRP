//
//  MainVC.swift
//  WaterTracker
//
//  Created by Ryan Phillips on 7/18/17.
//  Copyright © 2017 Ryan Phillips. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var amounts = [8,12,16,20,24,30,32,40,48,50,56,64]
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(backView)
        view.addSubview(titleLabel)
        view.addSubview(amountPicker)
        
        amountPicker.delegate = self
        amountPicker.dataSource = self
        
        setupWaterFeature()
        displayWater()
        setupOptions()
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
        waterView.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    func setupOptions() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
  
        amountPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        amountPicker.heightAnchor.constraint(equalToConstant: 120).isActive = true
        amountPicker.widthAnchor.constraint(equalToConstant: 150).isActive = true
        amountPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return amounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(amounts[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}

