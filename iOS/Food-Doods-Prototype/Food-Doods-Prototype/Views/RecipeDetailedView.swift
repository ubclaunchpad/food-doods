//
//  RecipeDetailedView.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-02-29.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit
import AlanYanHelpers

class RecipeInfoCell: UIView {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    convenience init(image: UIImage, text: String, size: CGFloat) {
        self.init()
        imageView.image = image
        label.text = text
        label.font = UIFont.systemFont(ofSize: size)
    }
    override init(frame: CGRect) {
         super.init(frame: frame)
         setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(label)
        setupConstraints()
    }

    //MARK: - Constraints Setup
    private func setupConstraints() {
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }
}


class RecipeDetailedView: UIView {
    var viewModel: RecipeModel! {
        didSet {
            #warning("Change picture")
            recipeImage.image = UIImage(named: "beefnoodles")
            bottomView.recipeLabel.text = viewModel.recipe.name
            
            bottomView.stackView.addArrangedSubview(RecipeImageTextView(image: UIImage(systemName: "timer"), size: 16, title: "\(Int(viewModel.recipe.time.cook)) minutes"))
            bottomView.stackView.addArrangedSubview(RecipeImageTextView(image: UIImage(systemName: "circle"), size: 16, title: "\(viewModel.recipe.servings) servings"))
            bottomView.stackView.addArrangedSubview(RecipeImageTextView(image: UIImage(systemName: "person.3"), size: 16, title: "2 People"))
            
            // MARK: NEED TO FIND NEW WAY TO FIGURE OUT INGREDIENTS MISSING
//            var ingredOwned: String = ""
//
//            for i in viewModel.ingredientsOwned {
//                ingredOwned.append(i.name)
//                ingredOwned.append("\n")
//            }
//
//            bottomView.ingredientsOwnedLabel.text = ingredOwned
//
//            var ingredNotOwned: String = ""
//
//            for i in viewModel.ingredientsNeeded {
//                ingredNotOwned.append(i.name)
//                ingredNotOwned.append("\n")
//            }
//
//            bottomView.ingredientsMissingLabel.text = ingredNotOwned
        }
    }
    
    //MARK: Subview Declarations
    var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var bottomView = RecipeScrollDescriptionView()
    var recipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
   
    func setupView() {
        addSubview(recipeImage)
        addSubview(bottomView)
        setupConstraints()
    }
   
    //MARK: - Constraints Setup
    private func setupConstraints() {
        recipeImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipeImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        recipeImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        recipeImage.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: -20).isActive = true
        bottomView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }
}


class RecipeScrollDescriptionView: UIScrollView {
    
    var recipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "CircularStd-Bold", size: 21)
        return label
    }()
    
    var selectionSegmentedControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        control.setButtonTitles(buttonTitles: ["Ingredients", "Preparation", "Reviews"])
        control.selectorViewColor = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        control.selectorTextColor = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        return control
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    var ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "CircularStd-Bold", size: 18)
        return label
    }()
    
    var youHaveLabel: UILabel = {
        let label = UILabel()
        label.text = "You have:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "CircularStd-Book", size: 18)
        return label
    }()
    
    var ingredientsOwnedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "14 oz new york strip steak (400g), or other steak of good quality \n2 teaspoons kosher salt \n2 tablespoons coarsely ground black pepper \n1 tablespoon vegetable oil"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "CircularStd-Book", size: 18)
        return label
    }()
    
    var youNeedLabel: UILabel = {
        let label = UILabel()
        label.text = "You're missing:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "CircularStd-Book", size: 18)
        return label
    }()
    
    var ingredientsMissingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "2 tablespoons butter, divided \n1 cup cream (240 mL) \n1/3 cup brandy or cognac (80 mL) \n1 tablespoon dijon mustard"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "CircularStd-Book", size: 18)
        return label
    }()
    override init(frame: CGRect) {
         super.init(frame: frame)
         setupView()
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        backgroundColor = .white
        addCorners(radius: 13, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner]).done()
        
        recipeLabel.setSuperview(self).addTop(constant: 25).addLeft(constant: 20).addRight(constant: -20).done()
                
        stackView.setSuperview(self).addLeft().addRight().addTop(anchor: recipeLabel.bottomAnchor, constant: 23).addHeight(withConstant: 30).done()
        
        selectionSegmentedControl.setSuperview(self).addTop(anchor: stackView.bottomAnchor, constant: 53).addLeft().addRight().addWidth(withConstant: UIScreen.main.bounds.width).done()

        ingredientLabel.setSuperview(self).addLeft(constant: 20).addTop(anchor: selectionSegmentedControl.bottomAnchor, constant: 22).done()
        
        youHaveLabel.setSuperview(self).addLeft(constant: 20).addTop(anchor: ingredientLabel.bottomAnchor, constant: 16).done()
        
        ingredientsOwnedLabel.setSuperview(self).addLeft(constant: 37).addTop(anchor: youHaveLabel.bottomAnchor, constant: 17).addRight(constant: -37).done()
        
        youNeedLabel.setSuperview(self).addLeft(constant: 20).addTop(anchor: ingredientsOwnedLabel.bottomAnchor, constant: 16).done()
        
        ingredientsMissingLabel.setSuperview(self).addLeft(constant: 37).addTop(anchor: youNeedLabel.bottomAnchor, constant: 17).addRight(constant: -37).addBottom().done()
     }
}


class RecipeImageTextView: UIView {
    var imageView = ContentFitImageView()
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    let view = UIView()
    convenience init(image: UIImage?, size: CGFloat, title: String) {
        self.init()
        imageView.image = image
        label.font = UIFont(name: "CircularStd-Book", size: size)
        label.text = title
        view.addWidth(withConstant: CGFloat(label.text!.count * 10)).done()
        setupView()
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         setupView()
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {

        view.setSuperview(self).addCenterX().addTop().addBottom().done()
        imageView.setSuperview(view).addLeft(constant: 0).addTop().addBottom().addWidth(anchor: heightAnchor).done()
        label.setSuperview(view).addLeft(anchor: imageView.rightAnchor, constant: 4).addCenterY().done()
     }
}
