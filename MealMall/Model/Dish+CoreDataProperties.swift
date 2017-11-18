//
//  Dish+CoreDataProperties.swift
//  
//
//  Created by Tim on 14.10.2017.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }
    
    @NSManaged public var uid: String
    @NSManaged public var image: NSObject?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int32
    @NSManaged public var weight: Int32
    @NSManaged public var category: Category
    @NSManaged public var restaurant: Restaurant?

}
