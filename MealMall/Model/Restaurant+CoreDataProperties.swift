//
//  Restaurant+CoreDataProperties.swift
//  
//
//  Created by Tim on 14.10.2017.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var uid: String
    @NSManaged public var deliveryTime: Int32
    @NSManaged public var foodDescription: String?
    @NSManaged public var image: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var startPrice: Int32
    @NSManaged public var dishes: NSSet?

}

// MARK: Generated accessors for dishes
extension Restaurant {

    @objc(addDishesObject:)
    @NSManaged public func addToDishes(_ value: Dish)

    @objc(removeDishesObject:)
    @NSManaged public func removeFromDishes(_ value: Dish)

    @objc(addDishes:)
    @NSManaged public func addToDishes(_ values: NSSet)

    @objc(removeDishes:)
    @NSManaged public func removeFromDishes(_ values: NSSet)

}
