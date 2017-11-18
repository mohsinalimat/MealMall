//
//  DataManager.swift
//  MealMall
//
//  Created by Tim on 24.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import CoreData

class DataManager {
    static func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]? where T: NSManagedObject {
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        return nil
    }
    
    static func fetchByUID<T>(uid: String, fetchRequest: NSFetchRequest<T>) -> T? where T: NSManagedObject {
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "uid == '\(uid)'")
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.count < 1 {return nil}
            return result[0]
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        return nil
    }
}
