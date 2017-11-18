//
//  CarouselHeaderCell.swift
//  MealMall
//
//  Created by Tim on 22.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class CarouselHeaderCell: UICollectionViewCell {
    
    static var ID = "CarouselHeaderCellID"
    static var startingGapID = "startingGapID"
    
    var carouselDelegate: FeaturedCarouselDelegate = {
        return FeaturedCarouselDelegate()
    }()
    
    static let itemGap: CGFloat = 10.0

    //featured items carousel
    lazy var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CarouselHeaderCell.itemGap
        let v = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.showsHorizontalScrollIndicator = false
        return v
    }()
    
    lazy var dividerLine: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 1))
        v.backgroundColor = .lightGray
        return v
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
        addSubview(carousel)
        addSubview(dividerLine)
        carousel.delegate = carouselDelegate
        carousel.dataSource = carouselDelegate
        carousel.register(FeaturedItemCell.self, forCellWithReuseIdentifier: FeaturedItemCell.ID)
        carousel.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CarouselHeaderCell.startingGapID)
    }
}
