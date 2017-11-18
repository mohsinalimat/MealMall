
//
//  CheckoutViewController.swift
//  MealMall
//
//  Created by Tim on 24.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import CoreData


class CheckoutViewController: UICollectionViewController, CheckoutCellDelegate {
    
    var items: [[String: Int]] {
        get {
            if let cart = UserDefaults.standard.dictionary(forKey: "cart") as? [String: Int] {
                return cart.filter({$0.value > 0}).map({ (key, value) -> [String: Int] in
                    return [key: value]
                })
            }
            return [[String: Int]]()
        }
        set {
            let result = newValue.reduce(into: [String: Int]()) { (result, item) in
                if let key = item.keys.first, let value = item.values.first {
                    if value == 0 {
                        result.removeValue(forKey: key)
                    } else {
                        result[key] = value
                    }
                    
                }
            }
            UserDefaults.standard.set(result, forKey: "cart")
        }
    }
    
    var subtotal: Float {
        let amount = items.reduce(into: 0) { (res, item) in
            let fetchRequest = NSFetchRequest<Dish>(entityName: "Dish")
            let dish: Dish = DataManager.fetchByUID(uid: item.keys.first!, fetchRequest: fetchRequest)!
            res += item.values.first! * Int(dish.price)
        }
        return Float(amount)
    }
    
    var accountingItems = ["Subtotal", "Promo discount", "Shipping", "Total"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.collectionView!.register(CheckoutItemViewCell.self, forCellWithReuseIdentifier: CheckoutItemViewCell.ID)
        self.collectionView!.register(AccountingCell.self, forCellWithReuseIdentifier: AccountingCell.ID)
        self.collectionView?.backgroundColor = UIColor.init(netHex: 0xEBEAEF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let finishButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Finish"
        return button
    }()
    
    func setupViews() {
        self.navigationItem.rightBarButtonItem = finishButton
    }
    
    func didTapRemove(indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        collectionView?.deleteItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 15, 0)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if section == 0 {
            count = items.count
        } else if section == 1 {
            count = accountingItems.count
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var resCell = UICollectionViewCell()
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CheckoutItemViewCell.ID, for: indexPath) as! CheckoutItemViewCell
            cell.delegate = self
            let dishUID = items[indexPath.row].keys.first!
            cell.dishUID = dishUID
            
            cell.quantityLabel.text = "\(items[indexPath.row].values.first!)"
            if let restUID = UserDefaults.standard.object(forKey: "currentRestaurant") as? String {
                let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
                if let restaurant = DataManager.fetchByUID(uid: restUID, fetchRequest: fetchRequest) as? Restaurant {
                    cell.cartDelegate = MenuDatasource(restaurant: restaurant)
                }
            }
            let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
            if let dish: Dish = DataManager.fetchByUID(uid: dishUID, fetchRequest: fetchRequest) {
                cell.nameLabel.text = dish.name!
                cell.priceLabel.text = "$\(dish.price)"
                cell.imageView.image = dish.image as? UIImage
            }
            
            cell.indexPath = indexPath
            resCell = cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountingCell.ID, for: indexPath) as! AccountingCell
            cell.titleLable.text = accountingItems[indexPath.row]
            if indexPath.row == 0 {
                cell.mainColor = UIColor.black
                cell.valueLabel.text = "$\(subtotal)"
            }
            if indexPath.row == 1 {
                cell.mainColor = UIColor.black
                cell.valueLabel.text = "-$\(0)"
            }
            if indexPath.row == 2 {
                cell.mainColor = UIColor.orange
                cell.valueLabel.text = "Free"
            }
            if indexPath.row == 3 {
                cell.mainColor = UIColor.black
                cell.valueLabel.text = "$\(subtotal)"
            }
            resCell = cell
        }
        
        return resCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}

extension CheckoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: view.frame.width, height: 10)
        if indexPath.section == 0 {
            size = CGSize(width: view.frame.width, height: 60)
        } else if indexPath.section == 1 {
            size = CGSize(width: view.frame.width, height: 45)
        }
        return size
    }
}

protocol CheckoutCellDelegate {
    func didTapRemove(indexPath: IndexPath)
}



