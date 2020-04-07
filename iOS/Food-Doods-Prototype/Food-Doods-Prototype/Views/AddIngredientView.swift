//
//  AddIngredientView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-04-07.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation
import UIKit
import AlanYanHelpers

//class AddIngredientView: UIView {
//    var addSub: UIView = {
//        let view = AddIngredientSubview()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 25
//        return view
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupView() {
//        self.backgroundColor = .black
//
//        addSubview(addSub)
//
//        addVanillaConstraints()
//    }
//
//    func addVanillaConstraints() {
//        addSub.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive = true
//        addSub.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0.0).isActive = true
//        addSub.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
//        addSub.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
//    }
//}

class AddIngredientView: UIView {
    var addSub: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        view.layer.opacity = 0.98
        return view
    }()
    
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "CircularStd-Bold", size: 24)
        label.text = "Add Item"
        label.textColor = .black
        return label
    }()
    
    var itemIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "groceries")
        return imageView
    }()
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(hex: 0xFF3730)
        
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 20)
        label.text = "X"
        label.textColor = .white
        label.setSuperview(button).addCenterX().addCenterY().done()
        
        return button
    }()
    
    var ingredientNameTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-80, height: 50))
        field.placeholder = "Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.clipsToBounds = true
        field.font = UIFont(name: "CircularStd-Book", size: 20)
        field.borderStyle = .roundedRect
        return field
    }()
    
    var amountTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-80, height: 50))
        field.placeholder = "Amount"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.clipsToBounds = true
        field.font = UIFont(name: "CircularStd-Book", size: 20)
        field.borderStyle = .roundedRect
        return field
    }()
    
    var expiryNumPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
//    var expiryUnitPicker: UIPickerView = {
//        let picker = UIPickerView()
//        picker.translatesAutoresizingMaskIntoConstraints = false
//        return picker
//    }()
    
    var locationPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(hex: 0x1BBF00)
        
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 20)
        label.text = "Add"
        label.textColor = .white
        label.setSuperview(button).addCenterX().addCenterY().done()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .clear
        
        addSubview(addSub)
        
        addSubview(itemIcon)
        addSubview(titleLabel)
        addSubview(dismissButton)
        
        addSubview(ingredientNameTextField)
        addSubview(amountTextField)
        
        addSubview(expiryNumPicker)
        addSubview(locationPicker)
        
        addSubview(addButton)
        
        addVanillaConstraints()
    }
    
    func addVanillaConstraints() {
        addSub.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive = true
        addSub.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0.0).isActive = true
        addSub.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        addSub.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true

        
        itemIcon.centerYAnchor.constraint(equalTo: addSub.topAnchor, constant: 0.0).isActive = true
        itemIcon.centerXAnchor.constraint(equalTo: addSub.centerXAnchor, constant: 0.0).isActive = true
        itemIcon.widthAnchor.constraint(equalTo: addSub.widthAnchor, multiplier: 0.3).isActive = true
        itemIcon.heightAnchor.constraint(equalTo: itemIcon.widthAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: itemIcon.bottomAnchor, constant: 0.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: addSub.leftAnchor, constant: 0.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: addSub.rightAnchor, constant: 0.0).isActive = true
        // titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dismissButton.topAnchor.constraint(equalTo: addSub.topAnchor, constant: 15.0).isActive = true
        dismissButton.rightAnchor.constraint(equalTo: addSub.rightAnchor, constant: -15.0).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        ingredientNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        ingredientNameTextField.centerXAnchor.constraint(equalTo: addSub.centerXAnchor, constant: 0.0).isActive = true
        ingredientNameTextField.widthAnchor.constraint(equalTo: addSub.widthAnchor, multiplier: 0.75).isActive = true
        ingredientNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        amountTextField.topAnchor.constraint(equalTo: ingredientNameTextField.bottomAnchor, constant: 10.0).isActive = true
        amountTextField.centerXAnchor.constraint(equalTo: addSub.centerXAnchor, constant: 0.0).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: addSub.widthAnchor, multiplier: 0.75).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        expiryNumPicker.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 15.0).isActive = true
        expiryNumPicker.widthAnchor.constraint(equalTo: addSub.widthAnchor, multiplier: 0.9).isActive = true
        expiryNumPicker.centerXAnchor.constraint(equalTo: addSub.centerXAnchor, constant: 0.0).isActive = true
        expiryNumPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        expiryUnitPicker.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 15.0).isActive = true
//        expiryUnitPicker.widthAnchor.constraint(equalTo: addSub.widthAnchor, multiplier: 0.4).isActive = true
//        expiryUnitPicker.rightAnchor.constraint(equalTo: addSub.rightAnchor, constant: -20.0).isActive = true
//        expiryUnitPicker.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        locationPicker.topAnchor.constraint(equalTo: expiryNumPicker.bottomAnchor, constant: 15.0).isActive = true
        locationPicker.widthAnchor.constraint(equalTo: addSub.widthAnchor, multiplier: 0.5).isActive = true
        locationPicker.centerXAnchor.constraint(equalTo: addSub.centerXAnchor, constant: 0.0).isActive = true
        locationPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        addButton.topAnchor.constraint(equalTo: locationPicker.bottomAnchor, constant: 15.0).isActive = true
        addButton.widthAnchor.constraint(equalTo: addSub.widthAnchor, multiplier: 0.5).isActive = true
        addButton.centerXAnchor.constraint(equalTo: addSub.centerXAnchor, constant: 0.0).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}










//MARK: - SwiftUI Preview
import SwiftUI


@available(iOS 13.0, *)
struct AddControllerPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return AddIngredientViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            return
        }
        
    }
}

