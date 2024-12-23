//
//  ContentView.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userSetting: UserSettings
    @State private var selectionTab: Int = 0
    var body: some View {
        ZStack{
            TabView(selection: $selectionTab) {
                HomeView()
                    .tag(0)
                    .tabItem({
                        Image(systemName: "house")
                        Text("Home")
                    })
                SettingView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "gearshape")
                            Text("Setting")
                    }
            }
            .accentColor(Color(userSetting.selectionThem.themColor))
            
        }
        .environment(\.locale, .init(identifier: userSetting.selectionLanguage.rawValue))
    }
    
}

struct SearchField: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search for food category", text: $text)
                .padding(.horizontal, 25)
                .overlay {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .fixedSize()
                        .scaledToFit()
                        .padding(.leading, 2)
                        .tint(.secondary.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
        }
        .padding(8)
        .background(.secondary.opacity(0.5))
    }
}


struct FilterView: View {
    var arryFoodCategoryItem: [FoodCategoryItem] = FoodCategoryItem.arrFoodCategoryItem
    @Binding var selectFoodCategory: [FoodCategoryItem]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack {
                ForEach(arryFoodCategoryItem) { category in
                    FilterButton(item: category, isSelection: selectFoodCategory.contains(where: {$0.name == category.name})) { selectionCategory in
                        if let index = selectFoodCategory.firstIndex(where: {$0.name == selectionCategory.name}) {
                            selectFoodCategory.remove(at: index)
                        }else {
                            selectFoodCategory.append(selectionCategory)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 50)
        
    }
}


struct FilterButton: View {
    @EnvironmentObject private var userSetting: UserSettings
    var item: FoodCategoryItem
    var isSelection: Bool = false
    var onTap:(FoodCategoryItem) -> ()
    var body: some View {
        Button {
            self.onTap(item)
        } label: {
            HStack {
                Text(LocalizedStringKey(item.name ?? ""))
                    .foregroundColor( Color(self.isSelection ? userSetting.selectionThem.themColor : .gray))
                    .fontWeight(self.isSelection ? .bold : .regular)
                if isSelection {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor( Color(self.isSelection ? userSetting.selectionThem.themColor : .gray))
                }
            }
            .padding(8)
            .overlay {
                Capsule()
                    .stroke(Color(self.isSelection ? userSetting.selectionThem.themColor : .gray), lineWidth: 1)
            }
        }
        .environment(\.locale, .init(identifier: userSetting.selectionLanguage.rawValue))

    }
}


struct SortFoodItemView: View {
    @EnvironmentObject private var userSetting: UserSettings
    @State var title: String = "Sort by"
    @Binding var item:[String]
    @Binding var selectionSegment: Int
    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(.title3)
                
            SortButtonView(selectionItem: $selectionSegment,item: $item)
        }
        .accentColor(Color.black)
    }
}

struct SortButtonView: View {
    @EnvironmentObject private var userSetting: UserSettings
    @Binding var selectionItem: Int
   @Binding var item:[String]
    var body: some View {
        ZStack {
            GeometryReader { reader in
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(userSetting.selectionThem.themColor))
                    .padding(2)
                    .frame(width: reader.size.width / CGFloat(item.count))
                    .shadow(radius: 2, x: 1, y: 0)
                    .offset(x: reader.size.width / CGFloat(item.count) * CGFloat(selectionItem), y: 0)
            }
            HStack {
                ForEach(0..<item.count, id: \.self) { i in
                    HStack {
                        segmentChangeButton(i)
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
                    
                }
            }
            
        }
        .frame(height: 40)
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(8)
        .environment(\.locale, .init(identifier: userSetting.selectionLanguage.rawValue))

    }
    
    @ViewBuilder
    func segmentChangeButton(_ index: Int) -> some View {
        Button {
            self.selectionItem = index
        } label: {
            Image(systemName: item[index])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct SearchBar: View {
    @EnvironmentObject private var userSetting: UserSettings
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField(LocalizedStringKey("Search for food category"), text: $text)
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.primary)
                .padding(7)
                .padding(.horizontal, 25)
                .background(colorScheme == .light ? .secondary.opacity(0.15): Color.secondary.opacity(0.25))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button {
                                self.text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    //.foregroundColor(Color(dataSource.selectedTheme.primaryColor))
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button {
                    withAnimation {
                        self.isEditing = false
                        self.text = ""
                    }
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .environment(\.locale, .init(identifier: userSetting.selectionLanguage.rawValue))
    }
}






