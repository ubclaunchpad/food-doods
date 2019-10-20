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
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let segments = ["All", "Pantry", "Fridge", "Dry"]
        let segmentControl = UISegmentedControl(items: segments)
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)

        return segmentControl
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
        fatalError("init(coder:) has not been implemented")
        setupView()
    }
    
    //custom view setup
    func setupView() {
        
        addSubview(tableView)
        addSubview(segmentControl)

        setupConstraints()
    }
    
    @objc
    private func segmentSelected(sender: UISegmentedControl) {
        print("a segment has been selected!")
    }
    
    //MARK: Constraints Setup
    private func setupConstraints() {
        segmentControl.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(20)).isActive = true
        segmentControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(10)).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(10)).isActive = true
        
    }
}
