//
//  MenuDatasource.swift
//  MealMall
//
//  Created by Tim on 19.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import CoreData
import ExpandableCell

let maxQuantity = 99

class MenuDatasource: NSObject, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<Dish>!
    var categories: [Category]?
    var dishes: [Dish]?
    var restaurant: Restaurant?
    
    init(restaurant: Restaurant) {
        super.init()
        self.restaurant = restaurant
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true), NSSortDescriptor(key: "category.name", ascending: true)]
        if let restaurantName = restaurant?.name {
            fetchRequest.predicate = NSPredicate(format: "restaurant.name == '\(restaurantName)'")
        }
        
        guard let dishes = DataManager.fetch(fetchRequest: fetchRequest) else {
            return
        }
        self.dishes = dishes
        let categorySet: Set<Category> = Set(dishes.map {$0.category})
        categories = Array(categorySet)
        
    }
    

}

extension MenuDatasource: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        var heights = [CGFloat]()
        if let relevantDishes = relevantDishesFor(indexPath: indexPath) {
            for _ in relevantDishes {
                heights.append(130)
            }
        }
        return heights
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        var cells = [UITableViewCell]()
        if let relevantDishes = relevantDishesFor(indexPath: indexPath) {
            relevantDishes.forEach {
                let cell = DishCell()
                
                cell.cartDelegate = self
                cell.dishUID = $0.uid
                cell.nameLabel.text = $0.name
                cell.infoLabel.text = $0.info
                cell.dishImage.image = $0.image as? UIImage
                cell.weightLabel.text = "\($0.weight)g"
                cell.priceLabel.text = "$\($0.price)"
                if let quantity = getQuantity(id: $0.uid) {
                    cell.setInitialQuantity(quantity)
                }
                cells.append(cell)
            }
        }

        return cells
    }
    
    func relevantDishesFor(indexPath: IndexPath) -> [Dish]? {
        if let category = categories?[indexPath.row], let dishes = dishes {
            
            let relevantDishes = dishes.filter { $0.category.name == category.name! }
            return relevantDishes
        }

        return nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 52
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        if let count = categories?.count {
            return count
        }
        return 0
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: CategoryCell.ID, for: indexPath) as! CategoryCell
        if let categories = categories {
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.name
        }
        return cell
    }
    


}

extension MenuDatasource: CartDelegate {
    func didTapAddToCart(id: String, completion: ((_ quantity: Int) -> Void)?) {
        
        guard let restaurant = self.restaurant else {
            print("Tim: Error: restaurant is not set")
            return
        }
        
        if let restID = UserDefaults.standard.object(forKey: "currentRestaurant") as? String, restID != restaurant.uid {
            let alert = UIAlertController(title: "Clear shopping cart?", message: "Do you want to clear shopping cart", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [unowned self] (action) in
                let cart = [id:1] // key:quantity
                self.setCart(cart, restaurantID: restaurant.uid)
                completion?(1)
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: false, completion: nil)
            return
        } else {
            var quanity = 1
            if var cart = UserDefaults.standard.dictionary(forKey: "cart") as? [String: Int] {
                print(cart)
                if cart[id] == nil {
                    cart[id] = 1
                } else {
                    cart[id] = cart[id]! + 1
                    quanity = cart[id]!
                }
                setCart(cart, restaurantID: restaurant.uid)
            } else {
                setCart([id:1], restaurantID: restaurant.uid)
            }
            completion?(quanity)
        }
    }
    
    func changeItemsQuantity(id: String, increment: Bool, completion: ((_ newQuantity: Int) -> Void)?) {
        guard var cart = UserDefaults.standard.dictionary(forKey: "cart") as? [String: Int] else {
            print("Tim: Error: restaurant is not set")
            return
        }
        guard let restaurant = self.restaurant else {
            print("Tim: Error: restaurant is not set")
            return
        }
        
        if cart[id] != nil {
            var newQuantity: Int
            if increment {
                cart[id] = cart[id]! + 1
                if cart[id]! >= maxQuantity {
                    cart[id] = maxQuantity
                }
                newQuantity = cart[id]!
            } else {
                cart[id] = cart[id]! - 1
                if cart[id]! <= 1 {
                    cart[id] = 1
                }
                newQuantity = cart[id]!
            }
            setCart(cart, restaurantID: restaurant.uid)
            completion?(newQuantity)
        }
        
    }
    
    private func getQuantity(id: String) -> Int? {
        guard var cart = UserDefaults.standard.dictionary(forKey: "cart") as? [String: Int] else {
            print("Tim: Error: cant get cart from UserDefaults")
            return nil
        }
        return cart[id]
    }
    
    private func setCart(_ cart: [String: Int], restaurantID: String) {
        UserDefaults.standard.set(cart, forKey: "cart")
        UserDefaults.standard.set(restaurantID, forKey: "currentRestaurant")
    }
    
    private func clearCart() {
        UserDefaults.standard.set([], forKey: "cart")
        UserDefaults.standard.set("", forKey: "currentRestaurant")
    }
    
    func removeItemFromCart(id: String, completion: @escaping () -> Void) {
        guard var cart = UserDefaults.standard.dictionary(forKey: "cart") as? [String: Int] else {
            print("Tim: Error: cant get cart from UserDefaults")
            return
        }
        guard let restaurant = self.restaurant else {
            print("Tim: Error: restaurant is not set")
            return
        }
        cart[id] = 0
        setCart(cart, restaurantID: restaurant.uid)
        completion()
    }
}

protocol CartDelegate {
    func didTapAddToCart(id: String, completion: ((_ quantity: Int) -> Void)?)
    func removeItemFromCart(id: String, completion: @escaping () -> Void)
    func changeItemsQuantity(id: String, increment: Bool, completion: ((_ newQuantity: Int) -> Void)?)
}


