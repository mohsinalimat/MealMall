//
//  CheckoutItemViewCell.swift
//  MealMall
//
//  Created by Tim on 24.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class CheckoutItemViewCell: UICollectionViewCell {
    
    static let ID = "checkoutItemCellID"
    var dishUID: String?
    
    var delegate: CheckoutCellDelegate?
    var cartDelegate: CartDelegate?
    var indexPath: IndexPath?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Salad"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "defRest"))
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = skyBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = skyBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "minus_filled"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        removeButton.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(changeQuantity(sender:)), for: .touchUpInside)
        minusButton.tag = 1
        plusButton.addTarget(self, action: #selector(changeQuantity(sender:)), for: .touchUpInside)
        plusButton.tag = 2
    }
    
    @objc func changeQuantity(sender: UIButton) {
        guard let cartDelegate = cartDelegate, let uid = dishUID else {
            print("cartDelegate or ID are not set ")
            return
        }
        if sender.tag == 1 {
            cartDelegate.changeItemsQuantity(id: uid, increment: false) { [unowned self] (newQuantity) in
                self.quantityLabel.text = "\(newQuantity)"
            }
        }
        if sender.tag == 2 {
            cartDelegate.changeItemsQuantity(id: uid, increment: true) { [unowned self] (newQuantity) in
                self.quantityLabel.text = "\(newQuantity)"
            }
        }
    }
    
    @objc func removeTapped() {
        if let indexPath = indexPath {
            delegate?.didTapRemove(indexPath: indexPath)
        } else {
            print("Tim: error: indexPath for cell is not set")
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        let buttonSize: CGFloat = 24
        addSubview(removeButton)
        addSubview(imageView)

        // removeButton
        addConstraint(NSLayoutConstraint(item: removeButton, attribute: NSLayoutAttribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: removeButton, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))

        //imageView
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.left, relatedBy: .equal, toItem: removeButton, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 10))
        
        let middleStack = UIStackView()
        middleStack.translatesAutoresizingMaskIntoConstraints = false
        middleStack.axis = .vertical
        middleStack.alignment = .leading
        middleStack.spacing = 3
        middleStack.addArrangedSubview(nameLabel)
        middleStack.addArrangedSubview(priceLabel)
        addSubview(middleStack)
        //middleStack
        addConstraint(NSLayoutConstraint(item: middleStack, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: middleStack, attribute: NSLayoutAttribute.left, relatedBy: .equal, toItem: imageView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 10))

        let rightStack = UIStackView()
        rightStack.translatesAutoresizingMaskIntoConstraints = false

        rightStack.addArrangedSubview(minusButton)
        rightStack.addArrangedSubview(quantityLabel)
        rightStack.addArrangedSubview(plusButton)
        addSubview(rightStack)
        rightStack.spacing = 5
        //rightStack
        addConstraint(NSLayoutConstraint(item: rightStack, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: rightStack, attribute: NSLayoutAttribute.right, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10))
        
    }
}
