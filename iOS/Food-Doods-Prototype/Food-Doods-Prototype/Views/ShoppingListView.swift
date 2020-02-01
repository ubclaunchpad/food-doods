//
//  ShoppingListView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-11-08.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ShoppingListView: UIView {
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        self.addSubview(tableView)
        setupConstraints()
    }
    
    //MARK: - Constraints Setup
    private func setupConstraints(){
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
 
    }
}
