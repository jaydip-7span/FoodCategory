//
//  FoodCategoryListApp.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 10/12/24.
//

import SwiftUI

@main
struct FoodCategoryListApp: App {
   // @ObservedObject var userSetting: UserSettings = UserSettings()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(UserSettings()).environment(\.locale, .init(identifier: "hi")).environment(\.managedObjectContext, CoreDataManager().continer.viewContext)
        }
    }
}
