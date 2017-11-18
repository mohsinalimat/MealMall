//
//  DishCell.swift
//  MealMall
//
//  Created by Tim on 21.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class DishCell: UITableViewCell {
    
    static let ID = "dishCell"
    
    var cartDelegate: CartDelegate?
    var dishUID: String?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$10"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "310g"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = .gray
        return label
    }()
    
    let dishImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "burger-brothers"))
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Beutiful and tasty! Hey buy it or go home"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .gray
        return label
    }()
    
    lazy var cartButton: UIButton = {
        let button = self.getCartButton()
        button.setTitle("ADD TO CART", for: .normal)
        button.setTitleColor(skyBlue, for: .normal)
        button.layer.borderColor = skyBlue.cgColor
        return button
    }()
    
    lazy var removeButton: UIButton = {
        let button = self.getCartButton()
        button.setTitle("REMOVE", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.tintColor = skyBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = skyBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16.0
        return stack
    }()
    
    let quantityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        cartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeItemFromCart), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(changeQuantity(sender:)), for: .touchUpInside)
        minusButton.tag = 1
        plusButton.addTarget(self, action: #selector(changeQuantity(sender:)), for: .touchUpInside)
        plusButton.tag = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func getCartButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        return button
    }
    
    @objc func changeQuantity(sender: UIButton) {
        guard let delegate = cartDelegate, let uid = dishUID else {
            print("cartDelegate or ID are not set ")
            return
        }
        if sender.tag == 1 {
            delegate.changeItemsQuantity(id: uid, increment: false) { [unowned self] (newQuantity) in
                self.quantityLabel.text = "\(newQuantity)"
            }
        }
        if sender.tag == 2 {
            delegate.changeItemsQuantity(id: uid, increment: true) { [unowned self] (newQuantity) in
                self.quantityLabel.text = "\(newQuantity)"
            }
        }
    }
    
    @objc func removeItemFromCart() {
        guard let delegate = cartDelegate, let uid = dishUID else {
            print("cartDelegate or ID are not set ")
            return
        }
        delegate.removeItemFromCart(id: uid) {[unowned self] in
            self.addAddToCartButton()
        }
    }
    
    @objc func addToCart() {
        guard let delegate = cartDelegate, let uid = dishUID else {
            print("cartDelegate or ID are not set ")
            return
        }
        delegate.didTapAddToCart(id: uid, completion: {[unowned self] (quantity) in
            self.addRemoveButton()
            self.quantityLabel.text = "\(quantity)"
        })
    }
    
    private func addRemoveButton() {
        cartButton.isHidden = true
        removeButton.isHidden = false
        quantityStack.isHidden = false
    }
    
    private func addAddToCartButton() {
        cartButton.isHidden = false
        removeButton.isHidden = true
        quantityStack.isHidden = true
    }
    
    func setInitialQuantity(_ quantity: Int) {
        if quantity > 0 {
            addRemoveButton()
            self.quantityLabel.text = "\(quantity)"
        }
    }
    

    private func setupViews() {
        
        let rootStack = UIStackView()
        rootStack.alignment = .fill
        rootStack.spacing = 10
        rootStack.axis = .horizontal
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rootStack)
        rootStack.addArrangedSubview(dishImage)
        addConstraint(NSLayoutConstraint(item: dishImage, attribute: .width, relatedBy: .equal, toItem: dishImage, attribute: .height, multiplier: 1, constant: 0))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": rootStack]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": rootStack]))
        
        let leftStack = UIStackView()
        leftStack.axis = .vertical
        
        leftStack.spacing = 5
        leftStack.distribution = .equalSpacing
        leftStack.addArrangedSubview(nameLabel)
        let priceAndWeight = UIStackView()
        priceAndWeight.translatesAutoresizingMaskIntoConstraints = false
        priceAndWeight.addArrangedSubview(priceLabel)
        priceAndWeight.alignment = .leading
        priceAndWeight.addArrangedSubview(weightLabel)
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 5))
        priceAndWeight.addArrangedSubview(spaceView)
        priceAndWeight.spacing = 5
        leftStack.addArrangedSubview(priceAndWeight)
        
        leftStack.addArrangedSubview(infoLabel)
        
        let buttonSpace = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        buttonStack.addArrangedSubview(cartButton)
        buttonStack.addArrangedSubview(removeButton)
        removeButton.isHidden = true
        quantityStack.addArrangedSubview(minusButton)
        quantityStack.addArrangedSubview(quantityLabel)
        quantityStack.addArrangedSubview(plusButton)
        quantityStack.isHidden = true
        buttonStack.addArrangedSubview(quantityStack)
        buttonStack.addArrangedSubview(buttonSpace)
        leftStack.addArrangedSubview(buttonStack)
        rootStack.addArrangedSubview(leftStack)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
