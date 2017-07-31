//
//  WeightCalcViewController.swift
//  WaterTracker
//
//  Created by Ryan Phillips on 7/19/17.
//  Copyright © 2017 Ryan Phillips. All rights reserved.
//

import UIKit
import CoreData

protocol DataSentDelegate {
    func updateWeight(weight: Int, units: Int)
}

class WeightCalcViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate {
    
    var weights = ["Pounds (lbs)","Kilograms (kgs)"]
    var weightUnit: Int?
    
    let weightText: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 5
        text.layer.borderColor = ColorScheme.lightPrimaryColor.cgColor
        text.layer.cornerRadius = 30
        text.font = UIFont(name: "Avenir next", size: 20)
        text.textAlignment = .center
        text.text = nil
        text.placeholder = "Enter Weight"
        text.keyboardType = .numberPad
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
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 30
        button.layer.borderColor = ColorScheme.lightPrimaryColor.cgColor
        button.layer.borderWidth = 5
        button.backgroundColor = .white
        button.setTitle("Save", for: .normal)
        button.setTitleColor(ColorScheme.darkPrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir next", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(setWeight), for: .touchUpInside)
        
        return button
    }()
    
    let weightPicker: UIPickerView = {
        let picker = UIPickerView()
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var delegate: DataSentDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightPicker.dataSource = self
        weightPicker.delegate = self
        
        view.addSubview(weightText)
        view.addSubview(describeText)
        view.addSubview(saveButton)
        view.addSubview(weightPicker)
        
        displayWeightSection()
//        attemptFetch()
        
        
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
        
        weightPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightPicker.heightAnchor.constraint(equalToConstant: 120).isActive = true
        weightPicker.widthAnchor.constraint(equalToConstant: 150).isActive = true
        weightPicker.topAnchor.constraint(equalTo: describeText.bottomAnchor).isActive = true
    }
    
    func setWeight() {
        
        if delegate != nil {
            
            if weightText.text != "" {
                //            var user: User!
                //            user = User(context: context)
                //            user.weight = Int16(weightText.text!)!
                var units: Int
                let weight = weightText.text!
                
                if weightUnit == nil || weightUnit == 0 {
                    units = 0
                } else {
                    units = 1
                }
                
                delegate?.updateWeight(weight: Int(weight)!, units: units)
                navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    
    
    //    func attemptFetch(){
    //
    //        let fetchedInfo: NSFetchRequest<User> = User.fetchRequest()
    //
    //        do {
    //            let results = try context.fetch(fetchedInfo)
    //            print("^^^^^^^^^^^^^^^^^^^^^^^")
    //            print(results)
    //        } catch {
    //            return
    //        }
    //
    
    //    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weights.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weights[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightUnit = pickerView.selectedRow(inComponent: 0)
    }
}
