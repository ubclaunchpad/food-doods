//
//  LoginViewDesign.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-04-05.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit
import AlanYanHelpers


class LoginViewDesign: UIView {
    var topImage = ContentFitImageView(image: UIImage(named: "login-top"))
    var bottomImage = ContentFitImageView(image: UIImage(named: "login-bottom"))
    var logoImage = ContentFitImageView(image: UIImage(named: "watermelonLogo"))
    var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "CircularStd-Book", size: 38)
        label.text = "keepfresh"
        label.textColor = UIColor(hex: 0x1BBF00)
        return label
    }()
    
    var usernameTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-80, height: 50))
        field.placeholder = "Username"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.clipsToBounds = true
        field.font = UIFont(name: "CircularStd-Book", size: 20)
        field.addBottomBorderWithColor(color: UIColor(hex: 0xB7B7B7), width: 1)
        return field
    }()
    
    var passwordTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-80, height: 50))
        field.placeholder = "Password"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.clipsToBounds = true
        field.font = UIFont(name: "CircularStd-Book", size: 20)
        field.addBottomBorderWithColor(color: UIColor(hex: 0xB7B7B7), width: 1)
        return field
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(hex: 0x1BBF00)
        
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 20)
        label.text = "Login"
        label.textColor = .white
        label.setSuperview(button).addCenterX().addCenterY().done()
      
        return button
    }()
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .blue
        button.setTitle("Dismiss", for: .normal)
        
        return button
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.text = "Status: "
        label.textAlignment = .center
        label.font = UIFont(name: "CircularStd-Book", size: 20)
        label.textColor = .white
        
        return label
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
        
        topImage.setSuperview(self).addTop().addLeft().addRight().addHeight(withConstant: 200).done()
        topImage.layer.opacity = 0.5
        
        logoImage.setSuperview(self).addTop(anchor: topImage.bottomAnchor, constant: 10).addCenterX().addHeight(withConstant: 70).addWidth(withConstant: 100).done()
        headerLabel.setSuperview(self).addTop(anchor: logoImage.bottomAnchor, constant: 10).addCenterX().done()
        usernameTextField.setSuperview(self).addTop(anchor: headerLabel.bottomAnchor, constant: 40).addLeading(constant: 40).addTrailing(constant: -40).addHeight(withConstant: 50).done()
        passwordTextField.setSuperview(self).addTop(anchor: usernameTextField.bottomAnchor, constant: 10).addLeading(constant: 40).addTrailing(constant: -40).addHeight(withConstant: 50).done()
        
        loginButton.setSuperview(self).addCenterX().addTop(anchor: passwordTextField.bottomAnchor, constant: 50).addWidth(withConstant: 200).addHeight(withConstant: 50).done()
        
        // MARK: Debugging Purposes
        dismissButton.setSuperview(self).addCenterX().addTop(anchor: loginButton.bottomAnchor, constant: 50).addWidth(withConstant: 200).addHeight(withConstant: 50).done()
        // MARK: - Debugging end
        
        
        bottomImage.setSuperview(self).addBottom().addLeft().addRight().addHeight(withConstant: 180).done()
        bottomImage.layer.opacity = 0.5
        
        
        statusLabel.setSuperview(self).addCenterX().addBottom(anchor: bottomAnchor, constant: 0).addWidth(anchor: widthAnchor, constant: 0).addHeight(withConstant: 50).done()
        
        statusLabel.isHidden = true
    }
}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}





class MainController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = LoginViewDesign()
        self.view = newView
    }
}

//MARK: SwiftUI Preview
import SwiftUI



@available(iOS 13.0, *)
struct ControllerPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        typealias UIViewControllerType = UIViewController
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ControllerPreview.ContainerView>) -> ControllerPreview.ContainerView.UIViewControllerType {
            return MainController()
        }
        
        func updateUIViewController(_ uiViewController: ControllerPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ControllerPreview.ContainerView>) {
            
        }
    }
}
