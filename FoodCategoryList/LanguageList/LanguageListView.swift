//
//  LanguageListView.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import SwiftUI

struct LanguageListView: View {
    @Environment(\.presentationMode) var presentionMode
    @EnvironmentObject private var userSetting: UserSettings
    
    var body: some View {
        VStack {
            List {
                ForEach(LanguageString.allCases, id: \.self){ index in
                    Button {
                        userSetting.language = index
                        presentionMode.wrappedValue.dismiss()
                    } label: {
                        Text(LocalizedStringKey(index.dispalyLanguage.rawValue))
                    }
                }
            }
        }
        .navigationTitle(LocalizedStringKey("Language List"))
       
    }
}


struct LanguageListView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageListView()
    }
}


enum LanguageString:String, CaseIterable {
    case en = "en"
    case hi = "hi"
//    case gr = "gr"
//    case gu = "gu"
}
extension LanguageString {
    var dispalyLanguage: LocalizationString {
        switch self {
        case .en:
            return .english
        case .hi:
            return .hindi
//        case .gr:
//            return .greek
//        case .gu:
//            return .gujarati
        }
    }
}

//extension LanguageString: LocalizationString {
//    switc
//}
//
enum LocalizationString: String {
case english = "English"
//case greek = "Greek"
case hindi = "Hindi"
//case gujarati = "Gujarati"
}
