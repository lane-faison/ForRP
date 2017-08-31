//
//  MainVC.swift
//  WaterTracker
//
//  Created by Ryan Phillips on 7/18/17.
//  Copyright © 2017 Ryan Phillips. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate, DataSentDelegate {
    
    var controller: NSFetchedResultsController<User>!
    
    var amounts = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128]
    
    var addedArray: [Int] = []
    var isPounds = true
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let waterView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorScheme.defaultPrimaryColor
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
    
    let ouncesLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "Goal"
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.textColor = ColorScheme.darkPrimaryColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let completedLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "- 100%"
        label.font = UIFont(name: "Avenir next", size: 18)
        label.textColor = ColorScheme.darkPrimaryColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emptyLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "- 0%"
        label.font = UIFont(name: "Avenir next", size: 18)
        label.textColor = ColorScheme.darkPrimaryColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let halfLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "- 50%"
        label.font = UIFont(name: "Avenir next", size: 18)
        label.textColor = ColorScheme.darkPrimaryColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.textColor = .lightGray
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
        button.addTarget(self, action: #selector(addWater), for: .touchUpInside)
        
        return button
    }()
    
    var waterHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waterHeight = NSLayoutConstraint(item: waterView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Calculate Goal", style: .plain, target: self, action: #selector(goToSetWeight))
        
        view.addSubview(backView)
        view.addSubview(titleLabel)
        view.addSubview(amountPicker)
        view.addSubview(addButton)
        view.addSubview(completedLevelLabel)
        view.addSubview(emptyLevelLabel)
        view.addSubview(halfLevelLabel)
        view.addSubview(ouncesLevelLabel)
        view.addSubview(currentLevelLabel)
        
        amountPicker.delegate = self
        amountPicker.dataSource = self
        
        amountPicker.selectRow(15, inComponent: 0, animated: true)
        
        setupWaterFeature()
        displayWater()
        setupOptions()
        attemptFetch()
    }
    
    func updateWeight(weight: Int, units: Int) {
        
        var user: User!
        user = User(context: context)
        
        user.weight = Int16(weight)
        user.units = Int16(units)
        user.date = Date() as NSDate
        
        
        ad.saveContext()
        print(user)
        
    }
    
    func goToSetWeight(){
        performSegue(withIdentifier: "toSetWeight", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSetWeight" {
            let weightCalcVC: WeightCalcViewController = segue.destination as! WeightCalcViewController
            weightCalcVC.delegate = self
        }
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
        
        currentLevelLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        currentLevelLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        currentLevelLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        currentLevelLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 75).isActive = true
        
        
    }
    
    func displayWaterHeight(height: Int) {
        self.waterView.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            self.waterHeight.constant = CGFloat(height)
            self.waterView.layoutIfNeeded()
        }
    }
    
    func displayWater() {
        
        waterView.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        waterView.widthAnchor.constraint(equalTo: waterImageView.widthAnchor).isActive = true
        waterView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10).isActive = true
        waterHeight.isActive = true
        
        ouncesLevelLabel.topAnchor.constraint(equalTo: waterImageView.topAnchor, constant: 12).isActive = true
        ouncesLevelLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ouncesLevelLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        ouncesLevelLabel.centerXAnchor.constraint(equalTo: waterImageView.centerXAnchor, constant: -112).isActive = true
        
        completedLevelLabel.topAnchor.constraint(equalTo: waterImageView.topAnchor, constant: 12).isActive = true
        completedLevelLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        completedLevelLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        completedLevelLabel.centerXAnchor.constraint(equalTo: waterImageView.centerXAnchor, constant: 112).isActive = true
        
        emptyLevelLabel.topAnchor.constraint(equalTo: waterImageView.topAnchor, constant: 185).isActive = true
        emptyLevelLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emptyLevelLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        emptyLevelLabel.centerXAnchor.constraint(equalTo: waterImageView.centerXAnchor, constant: 112).isActive = true
        
        halfLevelLabel.topAnchor.constraint(equalTo: waterImageView.topAnchor, constant: 100).isActive = true
        halfLevelLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        halfLevelLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        halfLevelLabel.centerXAnchor.constraint(equalTo: waterImageView.centerXAnchor, constant: 112).isActive = true
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
    
    func attemptFetch() {
        
        print("Attempting Fetch##############")
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let weightSort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [weightSort]
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try self.controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        guard let information = controller.fetchedObjects else { return }
        
        print(information)
        
        if information.count > 0 {
            let currentInformation = information[0]
            
            var maxAmount: Double
            
            if currentInformation.units == 0 {
                isPounds = true
                maxAmount = Double(currentInformation.weight) * 2/3
                
                let convertedNumber: Int = Int(maxAmount)
                
                ouncesLevelLabel.text = "\(convertedNumber) oz"
                
            } else {
                isPounds = false
                maxAmount = Double(currentInformation.weight) / 30 * 1000
                
                let convertedNumber: Int = Int(maxAmount)
                
                ouncesLevelLabel.text = "\(convertedNumber) ml"
                
            }
            amountPicker.reloadAllComponents()
            print("WEIGHT: \(currentInformation.weight)")
            print("UNITS: \(currentInformation.units)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        attemptFetch()
    }
    
    func sumOfNumbers(numbers: [Int]) {
        var total = 0
        for i in numbers {
            total += i
        }
        
        print(total)
        currentLevelLabel.text = "\(String(describing: total))"
        
        self.displayWaterHeight(height: total)
    }
    
    func addWater() {
        
        let selectedPicker: Int = amountPicker.selectedRow(inComponent: 0)
        
        addedArray.append(selectedPicker + 1)
        
        print("######################")
        print(addedArray)
        
        // Rebuild the height of the water level
        sumOfNumbers(numbers: addedArray)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return amounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch isPounds {
        case true:
            return "\(amounts[row]) oz"
        default:
            return "\(amounts[row]) ml"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
}

