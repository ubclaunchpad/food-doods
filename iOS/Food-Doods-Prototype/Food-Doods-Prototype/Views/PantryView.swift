//
//  PantryView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit
import AlanYanHelpers

class PantryView: UIView {
    //instance of tableView instantiated lazily
    
    var segmentControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        control.setButtonTitles(buttonTitles: ["All", "Pantry", "Fridge", "Dry"])
        control.selectorViewColor = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        control.selectorTextColor = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        return control
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
        
        segmentControl.addTop(constant: 10).done()
        segmentControl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 31).isActive = true
        //tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true

    }
}
