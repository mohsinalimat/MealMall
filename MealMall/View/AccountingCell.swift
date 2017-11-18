//
//  AccountingCell.swift
//  MealMall
//
//  Created by Tim on 27.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class AccountingCell: UICollectionViewCell, Dequeueable {
    
    static let ID = "AccountingCell"
    
    var mainColor = UIColor.black {
        didSet {
            titleLable.textColor = mainColor
            valueLabel.textColor = mainColor
        }
    }

    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        addSubview(titleLable)
        addSubview(valueLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[title][value]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["title": titleLable, "value": valueLabel]))
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        
    }
}

