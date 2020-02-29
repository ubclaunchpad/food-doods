//
//  EditItemView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-11-09.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class EditItemView: UIView {
    var itemIndex: Int?
    
    var itemName: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var amountText: UILabel = {
        let label = UILabel()
        
        label.text = "Amount"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var itemQuantity: UILabel = {
        let label = UILabel()

        label.text = "#"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var expiringText: UILabel = {
        let label = UILabel()
        
        label.text = "Expiring in"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var expiryDate: UILabel = {
        let label = UILabel()

        label.text = "# days"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var itemIcon: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2.0
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var nameInput: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Input Name"
        textField.text = ""
        
        textField.borderStyle = UITextField.BorderStyle.bezel

        
        textField.textAlignment = .center
        
        return textField
    }()
    
    var saveButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save!", for: .normal)
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.addTarget(self, action: #selector(savePressed(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func savePressed(sender: UIButton) {
        if let inputText = nameInput.text, let index = itemIndex {
            if (!inputText.isEmpty) {
                allItemArray[index].name = inputText
                itemName.text = inputText
            }
        }
        
   }
       
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        
        self.addSubview(itemName)
        self.addSubview(amountText)
        self.addSubview(itemQuantity)
        
        self.addSubview(expiringText)
        self.addSubview(expiryDate)
        
        self.addSubview(itemIcon)
        
        self.addSubview(nameInput)
        self.addSubview(saveButton)
        
        setupConstraints()
    }
    
    //MARK: Constraints Setup
    private func setupConstraints() {
        //--- itemName Constraints ---//
        itemName.leftAnchor.constraint(equalTo: itemIcon.rightAnchor, constant: 21).isActive = true
        itemName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        //--- amountText Constraints ---//
        amountText.leftAnchor.constraint(equalTo: itemIcon.rightAnchor, constant: 21).isActive = true
        amountText.bottomAnchor.constraint(equalTo: itemQuantity.topAnchor, constant: -10).isActive = true
        
        //--- itemQuantity Constraints ---//
        itemQuantity.leftAnchor.constraint(equalTo: itemIcon.rightAnchor, constant: 21).isActive = true
        itemQuantity.bottomAnchor.constraint(equalTo: itemIcon.bottomAnchor, constant: 0).isActive = true
        
        //--- expiringText Constraints ---//
        expiringText.leftAnchor.constraint(equalTo: amountText.rightAnchor, constant: 21).isActive = true
        expiringText.bottomAnchor.constraint(equalTo: expiryDate.topAnchor, constant: -10).isActive = true
        
        //--- expiryDate Constraints ---//
        expiryDate.leftAnchor.constraint(equalTo: amountText.rightAnchor, constant: 21).isActive = true
        expiryDate.bottomAnchor.constraint(equalTo: itemIcon.bottomAnchor, constant: 0).isActive = true
        
        //--- itemIcon Constraints ---//
        itemIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        itemIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 21).isActive = true
        itemIcon.widthAnchor.constraint(equalToConstant: 150).isActive = true
        itemIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        //--- nameInput Constraints ---//
        nameInput.topAnchor.constraint(equalTo: itemIcon.bottomAnchor, constant: 100).isActive = true
        nameInput.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        nameInput.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        
        //--- saveButton Constraints ---//
        saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -150).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
