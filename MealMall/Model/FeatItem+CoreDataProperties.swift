//
//  FeatItem+CoreDataProperties.swift
//  
//
//  Created by Tim on 23.10.2017.
//
//

import Foundation
import CoreData


extension FeatItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeatItem> {
        return NSFetchRequest<FeatItem>(entityName: "FeatItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: NSObject?

}
