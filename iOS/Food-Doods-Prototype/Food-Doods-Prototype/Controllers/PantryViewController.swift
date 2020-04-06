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



class PantryViewController: UIViewController, CustomSegmentedControlDelegate {
    var tableView: UITableView!
    
    var ingredients: UserIngredientsModel? {
        didSet {
            print("didSet...")
            print(ingredients)
            for ingred in ingredients!.ingredients {
                
                // MARK: RANDOM LOCATION GENERATION (TEMP FOR DEMO)
                var locIndex = Int.random(in: 0...2)
                var location = FoodLocation.all
                switch (locIndex) {
                case 0:
                    location = FoodLocation.freeze
                case 1:
                    location = FoodLocation.fridge
                case 2:
                    location = FoodLocation.pantry
                default:
                    print("Error: out of index range")
                }
                let shelfLife = Int.random(in: 2...14)
                let expiresInDays = Int.random(in: 1..<shelfLife)
                
                let imageName = ingred.name.lowercased()
                
                allItemArray.append(Item(name: ingred.name, image: UIImage(named: imageName), location: location, amount: Double(ingred.quantity) ?? 10.0, expires: expiresInDays, shelfLife: shelfLife))
            }
            
            itemArray = allItemArray
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CircularStd-Bold", size: 36)!]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = PantryView();
        tableView = newView.tableView
        newView.segmentControl.delegate = self
        self.view = newView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your Ingredients"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PantryTableViewCell.self, forCellReuseIdentifier: "PantryCell")
        tableView.separatorStyle = .none
        
//        //Array Population
//        allItemArray.append(Item(name: "Beef", image: UIImage(named: "steak"), location: FoodLocation.fridge, amount: 500, expires: 2, shelfLife: 3))
//        allItemArray.append(Item(name: "Carrot", image: UIImage(named: "carrot"), location: FoodLocation.fridge, amount: 300, expires: 5, shelfLife: 8))
//        allItemArray.append(Item(name: "Broccoli", image: UIImage(named: "broccoli"), location: FoodLocation.fridge, amount: 150, expires: 4, shelfLife: 7))
//        allItemArray.append(Item(name: "Chicken Breast", image: UIImage(named: "chickenbreast"), location: FoodLocation.fridge, amount: 300, expires: 1, shelfLife: 5))
//
//
//        //Pantry
//        allItemArray.append(Item(name: "Chocolate", image: UIImage(named: "chocolate"), location: FoodLocation.pantry, amount: 50, expires: 20, shelfLife: 31))
//        allItemArray.append(Item(name: "Peanut Butter", image: UIImage(named: "peanutbutter"), location: FoodLocation.pantry, amount: 350, expires: 80, shelfLife: 100))
//
//        //Dry
//        allItemArray.append(Item(name: "Rice", image: UIImage(named: "rice"), location: FoodLocation.dry, amount: 1000, expires: 365, shelfLife: 500))
//        allItemArray.append(Item(name: "Spaghetti", image: UIImage(named: "spaghetti"), location: FoodLocation.dry, amount: 300, expires: 60, shelfLife: 90))
//
//        itemArray = allItemArray
        
        // MARK: - Real API Setup
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.loginDelegate = self

        present(loginVC, animated: false, completion: {})
    }
    
    lazy var apiCompletion: (UserIngredientsModel) -> Void = {
        ingredients in
        self.ingredients = ingredients
    }
    
    
    func changeToIndex(index: Int) {
        var foodSection: FoodLocation?
        switch(index) {
        case 0: foodSection = .all
        case 1: foodSection = .pantry
        case 2: foodSection = .fridge
        case 3: foodSection = .freeze
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


protocol LoginDelegate {
    func fetchIngredients()
}
extension PantryViewController: LoginDelegate {
    func fetchIngredients() {
        IngredientAPIUtil.shared.getUserIngredientList(userID: "5e8a72243b4ffe3a0afb5f26", completionHandler: self.apiCompletion)
    }
}



extension PantryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10))
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 + 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PantryCell", for: indexPath)
        
        guard let pantryCell = cell as? PantryTableViewCell else {
            return cell
        }
        pantryCell.selectionStyle = .none
        //MARK: - Cell Population
        let item = itemArray[indexPath.row]

        pantryCell.mainText.text = item.name
        pantryCell.foodImage.image = item.image
        
        
        pantryCell.expiringText.text = "expiring in \(item.expiresIn) days"
        pantryCell.sectionText.text = "\(item.location)"
        
        pantryCell.amountText.text = "\(item.amount) g"
        
        
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
        let blue: CGFloat = 0.0
        
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
