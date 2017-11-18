//
//  RestaurantViewCell.swift
//  MealMall
//
//  Created by Tim on 13.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    private let dividerLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightGray
        return v
    }()
    
    let image: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "defRest"))
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        return label
    }()
    
    let foodDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let star: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "star")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.9"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
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
        let middleStackView = UIStackView()
        let rightStackView = UIStackView()
        
        addSubview(dividerLine)
        addSubview(image)
        middleStackView.addArrangedSubview(nameLabel)
        middleStackView.addArrangedSubview(foodDescriptionLabel)
        middleStackView.addArrangedSubview(shortDescriptionLabel)
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.axis = .vertical
        middleStackView.distribution = .equalSpacing
        middleStackView.alignment = .fill
        addSubview(middleStackView)
        rightStackView.addArrangedSubview(star)
        rightStackView.addArrangedSubview(ratingLabel)
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.spacing = 4
        addSubview(rightStackView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLine]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLine]))
        //
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v1(64)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": image]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1(64)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": image]))
        addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //
        addConstraint(NSLayoutConstraint(item: middleStackView, attribute: .left, relatedBy: .equal, toItem: image, attribute: .right, multiplier: 1, constant: 14))
        addConstraint(NSLayoutConstraint(item: middleStackView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .height, multiplier: 0.9, constant: 0))
        addConstraint(NSLayoutConstraint(item: middleStackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //
        addConstraint(NSLayoutConstraint(item: rightStackView, attribute: .top, relatedBy: .equal, toItem: middleStackView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: rightStackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -12))
        //
        addConstraint(NSLayoutConstraint(item: star, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 14))
        addConstraint(NSLayoutConstraint(item: star, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 14))
    }
}
