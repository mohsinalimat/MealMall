//
//  CategoryCell.swift
//  MealMall
//
//  Created by Tim on 21.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import ExpandableCell

class CategoryCell: ExpandableCell {
    
    static let ID = "categoryCellID"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .light)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
