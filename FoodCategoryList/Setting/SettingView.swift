//
//  SettingView.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userSetting: UserSettings
    let coloum = [GridItem(.adaptive(minimum: 60), spacing: 10)]
    var themArr = ThemeManager.themes
    @State var selectionThem: Int = UserSettings().selectionThemIndex
    @State private var isNavigation: Bool = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Setting")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(userSetting.selectionThem.themColor))
                VStack(alignment: .leading, spacing: 24) {
                    Text("Theme color")
                        
                    LazyVGrid(columns: coloum, spacing: 16) {
                        ForEach(0..<themArr.count, id: \.self) { i in
                            Button {
                                self.selectionThem = i
                                self.userSetting.selectionThemIndex = i
                            } label: {
                                Text("")
                                    .frame(width: 50,height: 50)
                                    .background(Color(themArr[i].themColor))
                                    .clipShape(Capsule())
                            }
                            .overlay(alignment: .bottomTrailing) {
                                if i == selectionThem {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                            }
                        }
                    }
                }
                HStack {
                    Text("App Language")
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(destination: LanguageListView(), isActive: $isNavigation) {
                        Button {
                            self.isNavigation = true
                        } label: {
                            Text(LocalizedStringKey(userSetting.selectionLanguage.dispalyLanguage.rawValue))
                            Image(systemName: "chevron.forward")
                        }
                    }
                }
Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(LocalizedStringKey("Langauge List"))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
