//
//  CustomTabBar.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-03-30.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit
import AlanYanHelpers


class TabBarButton: UIButton {
    var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "CircularStd-Book", size: 10)
        label.textColor = .black
        return label
    }()
    
    var headerImage = ContentFitImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(title: String, image: UIImage?) {
        self.init()
        headerLabel.text = title
        headerImage.image = image
        setupView()
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    func setupView() {
        backgroundColor = .clear
        headerImage.setSuperview(self).addCenterX().addWidth(withConstant: 24).addHeight(withConstant: 24).addTop(constant: 16).done()
        headerLabel.setSuperview(self).addCenterX().addTop(anchor: headerImage.bottomAnchor, constant: 8).done()
    }
}


class CustomTabBar: UITabBar {
    // (1)
    var tabItems = [TabBarButton]()
    convenience init(items: [TabBarButton]) {
        self.init()
        tabItems = items
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            let appearance = standardAppearance
            appearance.configureWithTransparentBackground()
            standardAppearance = appearance
        } else {
            // Fallback on earlier versions
            shadowImage = UIImage()
            backgroundImage = UIImage()
        }
        
       
        setupView()
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    func setupView() {
        if tabItems.count == 0 { return }
        var leading = leadingAnchor
        for i in 0..<tabItems.count {
            let item = tabItems[i]
            
            if(i == 2) {
                item.setSuperview(self).addLeading(anchor: leading, constant: 40).addTop().addBottom().addWidth(withConstant: 50).done()
            } else {
                item.setSuperview(self).addLeading(anchor: leading).addTop().addBottom().addWidth(withConstant: 50).done()
            }
            
            leading = item.trailingAnchor
        }

    }
}
