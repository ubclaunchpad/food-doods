//
//  ItemView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit
import AlanYanHelpers

class ItemView: UIView {
    var viewModel: Item! {
        didSet {
            itemIcon.image = UIImage(named: viewModel.name.lowercased())
            expiryDate.text = "\(viewModel.expiresIn) days"
            itemQuantity.text = "\(viewModel.amount) g"
        }
    }
    
    var amountText: UILabel = {
        let label = UILabel()
        
        label.text = "Amount"
        label.font = UIFont(name: "CircularStd-Book", size: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var itemQuantity: UILabel = {
        let label = UILabel()

        label.text = "#"
        label.font = UIFont(name: "CircularStd-Bold", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var expiringText: UILabel = {
        let label = UILabel()
        
        label.text = "Expiring in"
        label.font = UIFont(name: "CircularStd-Book", size: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var expiryDate: UILabel = {
        let label = UILabel()

        label.text = "# days"
        label.font = UIFont(name: "CircularStd-Bold", size: 18)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var itemIcon = ContentFitImageView()
    
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
                
        return button
    }()
       
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
        
        itemIcon.setSuperview(self).addLeft(constant: 10).addTopSafe(constant: 10).addWidth(withConstant: 40).addHeight(withConstant: 40).done()
        
        expiringText.setSuperview(self).addLeft(constant: 10).addTop(anchor: itemIcon.bottomAnchor, constant: 10).addWidth(withConstant: 100).done()
        
        expiryDate.setSuperview(self).addTop(anchor: expiringText.bottomAnchor, constant: 10).addLeft(constant: 10).addWidth(withConstant: 100).done()
        
        amountText.setSuperview(self).addLeft(anchor: expiringText.rightAnchor, constant: 10).addTop(anchor: itemIcon.bottomAnchor, constant: 10).addWidth(withConstant: 100).done()
        
        itemQuantity.setSuperview(self).addTop(anchor: amountText.bottomAnchor, constant: 10).addLeft(anchor: expiryDate.rightAnchor, constant: 10).done()
    }
    
    //MARK: Constraints Setup
    private func setupConstraints() {

    }
}

