//
//  UserSettings.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 12/12/24.
//

import SwiftUI
class UserSettings: ObservableObject  {
    @AppStorage("SelectThem") var selectionThemIndex = 0 {
        didSet {
            updateThem()
        }
    }
    init(){
        updateThem()
        updateLanguage()
    }
    @AppStorage("SelectLanguage") var language: LanguageString = .en {
        didSet {
            updateLanguage()
        }
    }
    @Published var selectionLanguage: LanguageString = .hi
    @Published var selectionThem: Theme = BlueTheme()
     func updateThem() {
        selectionThem = ThemeManager.getTheme(selectionThemIndex)
    }
    
    func updateLanguage(){
        selectionLanguage = language
    }
}
