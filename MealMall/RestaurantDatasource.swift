
//
//  RestaurantDelegate.swift
//  MealMall
//
//  Created by Tim on 14.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData


class RestaurantDatasource: NSObject, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<Restaurant>!
    
    func populateDatabase() {

        guard let path = Bundle.main.url(forResource: "rest", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: path, options: .mappedIfSafe)
            let json = JSON(data: data)
            var newRestaurants = [Restaurant]()
            if let rests = json["restaurants"].array {
                for rest in rests {
                    let newRestaurant = Restaurant(context: context)
                    newRestaurant.uid = UUID().uuidString
                    newRestaurant.name = rest["name"].string
                    newRestaurant.foodDescription = rest["foodDescription"].string
                    newRestaurant.rating = rest["rating"].double!
                    newRestaurant.deliveryTime = rest["deliveryTime"].int32!
                    newRestaurant.startPrice = rest["startPrice"].int32!
                    newRestaurant.image = UIImage(named: rest["imageURL"].string!)
                    newRestaurants.append(newRestaurant)
                }
            }
            var newCategories = [Category]()
            if let categories = json["categories"].array {
                for category in categories {
                    let newCategory = Category(context: context)
                    newCategory.name = category["name"].string
                    newCategories.append(newCategory)
                }
            }
            
            var newFeaturedItems = [FeatItem]()
            if let featuredItems = json["featItems"].array {
                for featuredItem in featuredItems {
                    let newFeaturedItem = FeatItem(context: context)
                    newFeaturedItem.name = featuredItem["name"].string
                    newFeaturedItem.image = UIImage(named: featuredItem["image"].string!)
                    newFeaturedItems.append(newFeaturedItem)
                }
            }
            
            ad.saveContext()
            var newDishes = [Dish]()
            if let dishes = json["dishes"].array {
                for dish in dishes {
                    let newDish = Dish(context: context)
                    newDish.uid = UUID().uuidString
                    newDish.name = dish["name"].string
                    newDish.info = dish["info"].string
                    newDish.price = dish["price"].int32!
                    newDish.weight = dish["weight"].int32!
                    let categories = newCategories.filter { $0.name == dish["category"].string }
                    if categories.count > 0 {
                        newDish.category = categories[0]
                    }
                    let restaurants = newRestaurants.filter { $0.name == dish["restaurant"].string }
                    if restaurants.count > 0 {
                        newDish.restaurant = restaurants[0]
                    }
                    newDish.image = UIImage(named: dish["image"].string!)

                    newDishes.append(newDish)
                }
            }
            ad.saveContext()
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        fetchRequest.sortDescriptors =  []
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
}

extension RestaurantDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let fetchedObjects = controller.fetchedObjects {
            return fetchedObjects.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestCellID, for: indexPath) as! RestaurantCell
        let rest = controller.object(at: indexPath)
        
        cell.image.image = rest.image as? UIImage
        cell.nameLabel.text = rest.name
        cell.ratingLabel.text = "\(rest.rating)"
        cell.foodDescriptionLabel.text = rest.foodDescription
        cell.shortDescriptionLabel.text = "Order from $\(rest.startPrice) * \(rest.deliveryTime) min delivery"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if kind == UICollectionElementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CarouselHeaderCell.ID, for: indexPath) as! CarouselHeaderCell
                
                return header
            }
        }
        return UICollectionReusableView(frame: CGRect.zero)
    }
}

