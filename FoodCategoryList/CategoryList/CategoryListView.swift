//
//  CategoryListView.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import SwiftUI

struct CategoryListView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectionCategory: FoodCategoryItem
    var body: some View {
        List {
            ForEach(FoodCategoryItem.arrFoodCategoryItem) { foodcategory in
                Button {
                    self.selectionCategory = foodcategory
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text(foodcategory.icon ?? "")
                        Text(LocalizedStringKey(foodcategory.name ?? ""))
                    }
                }

            }
        }
    }
}
