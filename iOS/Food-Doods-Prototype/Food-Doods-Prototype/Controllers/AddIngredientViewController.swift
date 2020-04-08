//
//  AddIngredientViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-04-07.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation
import UIKit


class AddIngredientViewController: UIViewController {
    var myView: UIView!
    var nameTextField: UITextField!
    var amountTextField: UITextField!
    
    var expiryPicker: UIPickerView!
    var locationPicker: UIPickerView!
    
    var expiryController: ExpiryPickerController!
    var locationController: LocationPickerController!
    
    var addDelegate: AddIngredientDelegate?
    
    // MARK: Pls use this Alan
    func scheduleNotification(for seconds: Int, item: Item) {
        let content = UNMutableNotificationContent()
        
        content.title = "\(item.name) is expiring today!"
        content.body = "Be sure to cook your \(Int(item.amount))grams of \(item.name)s today!"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newView = AddIngredientView()
        newView.addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        newView.dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        
        nameTextField = newView.ingredientNameTextField
        amountTextField = newView.amountTextField
        
        // MARK: ExpiryPicker Delegation Setup
        let expiryNums = ["1", "2" , "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
        let expiryVals = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
        
        let expiryUnits = ["week(s)", "day(s)", "sec (DEMO)"]
        let expiryUnitVals = [1*60*24*7, 1*60*24, 1]
        
        let expiryNumController = ExpiryPickerController(numDisplay: expiryNums, numVal: expiryVals, unitDisplay: expiryUnits, unitVal: expiryUnitVals)
        
        newView.expiryNumPicker.delegate = expiryNumController
        newView.expiryNumPicker.dataSource = expiryNumController
        newView.expiryNumPicker.reloadAllComponents()
        
        
        // MARK: LocationPicker Delegation Setup
        let locations = [ "Pantry", "Fridge", "Freeze"]
        let locVals = [FoodLocation.pantry, FoodLocation.fridge, FoodLocation.freeze]
        
        let locationPickerController = LocationPickerController(display: locations, val: locVals)
        
        newView.locationPicker.delegate = locationPickerController
        newView.locationPicker.dataSource = locationPickerController
        newView.locationPicker.reloadAllComponents()
        
        
        addChild(expiryNumController)
        addChild(locationPickerController)
        
        expiryController = expiryNumController
        locationController = locationPickerController
        
        expiryPicker = newView.expiryNumPicker
        locationPicker = newView.locationPicker
        
        self.view = newView
        myView = newView
    }
    
    @objc func addPressed() {
        guard let name = nameTextField.text, let amountText = amountTextField.text else { return }
        guard let amount = Int(amountText) else { return }
        
        let location = locationController.locValue[locationPicker.selectedRow(inComponent: 0)]
        
        
        let expiryVal = expiryController.numVal[expiryPicker.selectedRow(inComponent: 0)]
        let expiryMultiple = expiryController.unitVal[expiryPicker.selectedRow(inComponent: 1)]
        
        var expires = 0
        var shelfLife =  1
        
        if expiryMultiple == 1 {
            // seconds, leave at 0 days
        } else if expiryMultiple == 1*60*24 {
            //days
            expires = expiryVal
            shelfLife = expiryVal
        } else {
            //weeks
            expires = expiryVal * 7
            shelfLife = expiryVal * 7
        }
        
        let image = UIImage(named: name.lowercased()) ?? UIImage(named: "groceries")
                
        let newItem = Item(name: name, image: image, location: location, amount: Double(amount), expires: expires, shelfLife: shelfLife)
        
        if let delegate = addDelegate {
            delegate.addNewLocalIngredient(item: newItem)
            scheduleNotification(for: expiryVal * expiryMultiple, item: newItem)
            dismiss(animated: true, completion: {})
        }
    }
    
    @objc func dismissPressed() {
        dismiss(animated: true, completion: {})
    }
}



// MARK: - Picker View Delegate
class ExpiryPickerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    var numDisplay: [String]
    var numVal: [Int]
    
    var unitDisplay: [String]
    var unitVal: [Int]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numDisplay.count
        } else {
            return unitDisplay.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return numDisplay[row]
        } else {
            return unitDisplay[row]
        }
    }

    
    // MARK: - UIViewController Init Stuff
    init(numDisplay: [String], numVal: [Int], unitDisplay: [String], unitVal: [Int]) {
        self.numDisplay = numDisplay
        self.numVal = numVal
        self.unitDisplay = unitDisplay
        self.unitVal = unitVal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LocationPickerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    var locDisplay: [String]
    var locValue: [FoodLocation]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locDisplay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locDisplay[row]
        
    }

    
    // MARK: - UIViewController Init Stuff
    init(display: [String], val: [FoodLocation]) {
        self.locDisplay = display
        self.locValue = val
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
