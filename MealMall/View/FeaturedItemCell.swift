//
//  FeaturedCell.swift
//  MealMall
//
//  Created by Tim on 24.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class FeaturedItemCell: UICollectionViewCell {
    static let ID = "FeaturedItemCellID"
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        return label
    }()
    
    let image: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "defRest"))
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
//        self.layer.cornerRadius = 6
//        self.layer.masksToBounds = true
        addSubview(image)
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":image]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1":nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-5-[v1(20)]-6-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": image, "v1": nameLabel]))
    }
    
}
