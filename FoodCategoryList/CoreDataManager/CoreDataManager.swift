//
//  CoreDataManager.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import Foundation
import CoreData

class CoreDataManager: NSObject,ObservableObject {
    let continer:NSPersistentContainer = NSPersistentContainer(name: "FoodCategory")
    

    override init() {
        super.init()
            continer.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Failed to load coredata stack:\(error)")
                }
            
        }
    }
}
