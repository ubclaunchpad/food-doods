//
//  FirstViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-14.
//  Copyright © 2019 Wren Liang. All rights reserved.
//
 
import UIKit

//MARK: Temporary Global Variables for Demo
var allItemArray: [Item] = []
var itemArray: [Item] = []



class PantryViewController: UIViewController {
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = PantryView();
        tableView = newView.tableView
        newView.segmentControl.selectedSegmentIndex = 0
        newView.segmentControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        self.view = newView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ingredients"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PantryTableViewCell.self, forCellReuseIdentifier: "PantryCell")
        tableView.separatorStyle = .none
        
        //Array Population
        allItemArray.append(Item(name: "Beef", image: UIImage(named: "steak"), location: FoodLocation.fridge, amount: 500, expires: 2, shelfLife: 3))
        allItemArray.append(Item(name: "Carrot", image: UIImage(named: "carrot"), location: FoodLocation.fridge, amount: 300, expires: 5, shelfLife: 8))
        allItemArray.append(Item(name: "Broccoli", image: UIImage(named: "broccoli"), location: FoodLocation.fridge, amount: 150, expires: 4, shelfLife: 7))
        allItemArray.append(Item(name: "Chicken Breast", image: UIImage(named: "chickenbreast"), location: FoodLocation.fridge, amount: 300, expires: 1, shelfLife: 5))
        

        //Pantry
        allItemArray.append(Item(name: "Chocolate", image: UIImage(named: "chocolate"), location: FoodLocation.pantry, amount: 50, expires: 20, shelfLife: 31))
        allItemArray.append(Item(name: "Peanut Butter", image: UIImage(named: "peanutbutter"), location: FoodLocation.pantry, amount: 350, expires: 80, shelfLife: 100))
        
        //Dry
        allItemArray.append(Item(name: "Rice", image: UIImage(named: "rice"), location: FoodLocation.dry, amount: 1000, expires: 365, shelfLife: 500))
        allItemArray.append(Item(name: "Spaghetti", image: UIImage(named: "spaghetti"), location: FoodLocation.dry, amount: 300, expires: 60, shelfLife: 90))
        
        itemArray = allItemArray
        
    }
    
    
    
    @objc
    private func segmentSelected(sender: UISegmentedControl) {
        var foodSection: FoodLocation?
        switch(sender.selectedSegmentIndex) {
        case 0: foodSection = .all
        case 1: foodSection = .pantry
        case 2: foodSection = .fridge
        case 3: foodSection = .dry
        default:
            print("Fatal error")
        }
        itemArray = []
        for item in allItemArray {
            if item.location == foodSection || foodSection == .all {
                itemArray.append(item)
            }
        }
        self.tableView.reloadData()
    }

}



extension PantryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10))
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PantryCell", for: indexPath)
        
        guard let pantryCell = cell as? PantryTableViewCell else {
            return cell
        }
        //MARK: - Cell Population
        let item = itemArray[indexPath.row]
        pantryCell.mainText.text = item.name
        pantryCell.foodImage.image = item.image
        pantryCell.expiringText.text = "expiring in \(item.expiresIn) days"
        
        var percentage: Float = 1.0
        if item.expiresIn < 6 {
             let expires = Float (item.expiresIn)
             percentage = expires / 7.0
         }
        
        let color = calcColor(expiryPercentage: percentage, item: item)
        pantryCell.expiryBar.setProgress(percentage, animated: true)
        pantryCell.expiryBar.tintColor = color


        
        return pantryCell
    }
    
    private func calcColor(expiryPercentage: Float, item: Item) -> UIColor {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat = 0.0
        
        var percentage = expiryPercentage
        
        if item.expiresIn < 6 {
            let expires = Float (item.expiresIn)
            percentage = expires / 7.0
            
            if percentage > 0.5 {
                green = 1.0
                red = CGFloat(percentage - 0.5)
            } else {
                green = CGFloat(percentage)
                red = 1.0
            }
        } else {
            green = 1.0
            red = 0.0
        }
        
        
        
        
        
        
        return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pushVC = ItemViewController()
        pushVC.item = itemArray[indexPath.row]
        pushVC.itemIndex = indexPath.row
        
        navigationController?.pushViewController(pushVC, animated: true)
    }
    
}
