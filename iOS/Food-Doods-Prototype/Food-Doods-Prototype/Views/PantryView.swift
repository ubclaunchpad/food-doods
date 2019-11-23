//
//  PantryView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


class PantryView: UIView {
    //instance of tableView instantiated lazily
    
    lazy var segmentControl: UISegmentedControl = {
        let segments = ["All", "Pantry", "Fridge", "Dry"]
        let segmentControl = UISegmentedControl(items: segments)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.tableHeaderView = self.segmentControl
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    //default false -> setting to true to allow contstraint based layout
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    //Initializes the view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //fallback if view doesn't initialize
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //custom view setup
    func setupView() {
        backgroundColor = .white
        addSubview(tableView)

        setupConstraints()
    }
    
    //MARK: Constraints Setup
    private func setupConstraints() {
        
        //segmentControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        segmentControl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 31).isActive = true
        //tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
