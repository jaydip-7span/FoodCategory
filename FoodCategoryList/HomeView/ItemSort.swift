//
//  ItemSort.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 12/12/24.
//

import Foundation
enum SortType: String, CaseIterable {
    case expiredDate
    case quantity
}

extension SortType: Identifiable {
    var id: String { rawValue }
}

enum SortOrder: String, CaseIterable {
    case ascending
    case descending
}

extension SortOrder: Identifiable {
    var id: String { rawValue }
}

struct ItemSort {
    var sortType:Int = 0
    var sortOrder:Int = 0
//
    var isAscending: Bool {
        sortOrder == 0 ? true : false
    }
    
    var sortDescriptor: NSSortDescriptor {
        switch sortType {
        case 0:
            return NSSortDescriptor(keyPath: \FoodCategoryList.expiredate, ascending: isAscending)
        case 1:
            return NSSortDescriptor(keyPath: \FoodCategoryList.quntity, ascending: isAscending)
        default:
            return NSSortDescriptor()
        }
    }
}
