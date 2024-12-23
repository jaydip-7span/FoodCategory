//
//  HomeView.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import Foundation
import SwiftUI
import CoreData
struct HomeView: View {
    
    @EnvironmentObject  var userSetting: UserSettings
    @State private var searchText: String = ""
    @State private var selectionCategory: [FoodCategoryItem] = []
    @State var selectionSortSegment: Int = 0
    @State var segmentSortItem:[String] = ["calendar", "number", "arrow.up"]
    @State var selectionOrderSegment: Int = 0
    @State var segmentOrderItem:[String] = ["arrow.up", "arrow.down"]
    
    
    
    @State private var arrCategory:[String] = []
    @State private var isAddCategory: Bool = false
    var body: some View {
        VStack(spacing: 16) {
            // headerview
            HStack {
                Text("Food Category")
                    .bold()
                    .font(.title)
                    .foregroundColor(Color(userSetting.selectionThem.themColor))
                Spacer()
                Button {
                    self.isAddCategory.toggle()
                } label: {
                    Image(systemName: "plus")
                        .tint(.white)
                }
                .frame(width: 20, height: 20)
                .padding(8)
                .background(
                    Capsule()
                        .fill(Color(userSetting.selectionThem.themColor)))
                .sheet(isPresented: $isAddCategory) {
                    AddCategory()
                        .presentationDetents([.fraction(0.95)])
                }
            }
            .padding(.horizontal)
            // searchbar
            SearchBar(text: $searchText)
                .padding(.bottom)
            
            // filterview
            FilterView(selectFoodCategory: $selectionCategory)
            
            // sortedFoodView
            HStack(spacing: 16) {
                SortFoodItemView(title: "Sort by", item: $segmentSortItem, selectionSegment: $selectionSortSegment)
                SortFoodItemView(title: "Order by", item: $segmentOrderItem, selectionSegment: $selectionOrderSegment)
            }
            .padding(.horizontal)
            
            FoodItemListShow(predeicate: FoodCategoryList.predicate(with: selectionCategory, searchText: searchText), sortDescription:ItemSort(sortType: selectionSortSegment, sortOrder: selectionOrderSegment).sortDescriptor)
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserSettings())
    }
}


extension Date {
    func asString(with format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


struct FoodItemListShow: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var pepole: FetchedResults<FoodCategoryList>
    @State private var isAddCategory: Bool = false
    @State private var singalSelection: FoodCategoryList?
    
    init(predeicate: NSPredicate?, sortDescription: NSSortDescriptor) {
        let fetchRequest = NSFetchRequest<FoodCategoryList>(entityName: FoodCategoryList.entity().name ?? "FoodCategoryList")
        fetchRequest.sortDescriptors = [sortDescription]
        
        if let predeicate = predeicate {
            fetchRequest.predicate = predeicate
        }
        
        _pepole = FetchRequest(fetchRequest: fetchRequest)
    }
    var body: some View {
        List {
            ForEach(pepole) { i in
                Button {
                    self.singalSelection = i
                } label: {
                    HStack {
                        Text(i.categoryItem?.icon ?? "")
                        VStack(alignment: .leading) {
                            Text(i.name ?? "")
                            Text(LocalizedStringKey("Expire Date"))
                                .font(.caption)
                            +
                            Text(" \(i.expiredate?.asString() ?? "")")
                                .font(.caption)
                        }
                        Spacer()
                        Text("x \(i.quntity, specifier: "%.0f")")
                    }
                    .padding(8)
                }
               
            }
        }
        .padding(.bottom)
        .overlay(alignment: .center) {
            if pepole.count == 0 {
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
        .sheet(item: $singalSelection, onDismiss: {
            self.singalSelection = nil
        }, content: { item in
            AddCategory(foodCategoryList: item)
        })
    }
    
}


