//
//  FoodCategoryItem.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import Foundation
struct FoodCategoryItem: Identifiable {
    var name: String?
    var icon: String?
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    init(){}
    static var arrFoodCategoryItem:[FoodCategoryItem] = [FoodCategoryItem(name: "vegetables", icon: "🥦"),FoodCategoryItem(name: "fruits",icon: "🍎"),FoodCategoryItem(name: "meat",icon: "🍖"),FoodCategoryItem(name: "fish",icon: "🐟"),FoodCategoryItem(name: "beverage",icon: "🍞"),FoodCategoryItem(name: "canned",icon: "🥫"),FoodCategoryItem(name: "freezer",icon: "❄️"),FoodCategoryItem(name: "diary",icon: "🧀"),FoodCategoryItem(name: "snack",icon: "🍪"),FoodCategoryItem(name: "others",icon: "🦄")]
}

extension FoodCategoryItem {
    var id: String {
        self.name ?? ""
    }
}
