//
//  ThemeModel.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import Foundation
import UIKit
protocol Theme {
    var themColor: UIColor { get }
    var themeName: String { get }
}

struct BlueTheme: Theme {
    var themColor: UIColor = UIColor(named: "Blue-PrimaryColor")!
    var themeName: String = "Blue Theme"
}

struct GreenTheme: Theme {
    var themColor: UIColor = UIColor(named: "Green-PrimaryColor")!
    var themeName: String = "Green Theme"
}

struct CyanTheme: Theme {
    var themColor: UIColor = UIColor(named: "Cyan-PrimaryColor")!
    var themeName: String = "Cyan Theme"
}

struct GeekBlueTheme: Theme {
    var themColor: UIColor = UIColor(named: "GeekBlue-PrimaryColor")!
    var themeName: String = "GeekBlue Theme"
}

struct PurpleTheme: Theme {
    var themColor: UIColor = UIColor(named: "Purple-PrimaryColor")!
    var themeName: String = "Purple Theme"
}

// Row 2
struct RedTheme: Theme {
    var themColor: UIColor = UIColor(named: "Red-PrimaryColor")!
    var themeName: String = "Red Theme"
}

struct PinkTheme: Theme {
    var themColor: UIColor = UIColor(named: "Pink-PrimaryColor")!
    var themeName: String = "Pink Theme"
}

struct OrangeTheme: Theme {
    var themColor: UIColor = UIColor(named: "Orange-PrimaryColor")!
    var themeName: String = "Orange Theme"
}

struct GoldTheme: Theme {
    var themColor: UIColor = UIColor(named: "Gold-PrimaryColor")!
    var themeName: String = "Gold Theme"
}

struct SimpleTheme: Theme {
    var themColor: UIColor = UIColor(named: "Simple-PrimaryColor")!
    var themeName: String = "Simple Theme"
}


enum ThemeManager {
    static let themes: [Theme] = [
        BlueTheme(), GreenTheme(), CyanTheme(), GeekBlueTheme(), PurpleTheme(),
        RedTheme(), PinkTheme(), OrangeTheme(), GoldTheme(), SimpleTheme()
    ]
    
    static func getTheme(_ them: Int) -> Theme {
        return themes[them]
    }
}
