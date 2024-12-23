//
//  FoodCategoryList+CoreDataProperties.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 12/12/24.
//
//

import Foundation
import CoreData


extension FoodCategoryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodCategoryList> {
        return NSFetchRequest<FoodCategoryList>(entityName: "FoodCategoryList")
    }

    @NSManaged public var quntity: Double
    @NSManaged public var category: String?
    @NSManaged public var expiredate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var purchasedate: Date?

}

extension FoodCategoryList : Identifiable {
    var categoryItem: FoodCategoryItem?{
        get {
            if let indext = FoodCategoryItem.arrFoodCategoryItem.firstIndex(where: {$0.name == category}) {
                return FoodCategoryItem.init(name: FoodCategoryItem.arrFoodCategoryItem[indext].name ?? "", icon: FoodCategoryItem.arrFoodCategoryItem[indext].icon ?? "")
            }
            return nil
        }
        set {
            self.category = newValue?.name ?? ""
        }
    }
    
    static func predicate(with foodCategory: [FoodCategoryItem], searchText: String) -> NSPredicate? {
        var predicat = [NSPredicate]()
        if !foodCategory.isEmpty {
            let categoryIndex = foodCategory.map({$0.name})
            for categoryName in categoryIndex {
                predicat.append(NSPredicate(format: "category == %@", categoryName ?? ""))
            }
        }
        if !(searchText.isEmpty) {
            predicat.append(NSPredicate(format: "name CONTAINS[cd] %@", searchText.lowercased()))
        }
        if predicat.isEmpty {
            return nil
        }else {
            return NSCompoundPredicate(orPredicateWithSubpredicates: predicat)
        }
       
    }
}
