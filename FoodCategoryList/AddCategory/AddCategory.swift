//
//  AddCategory.swift
//  FoodCategoryList
//
//  Created by jaydip jadav on 11/12/24.
//

import SwiftUI

struct AddCategory: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject private var userSetting: UserSettings
    
    @State private var text: String = ""
    @State private var quntity:String = ""
    @State private var isPurchePickerOn: Bool = false
    @State private var isExpirePickerOn: Bool = false

    @State private var purchesDate: Date = Date()
    @State private var expireDate: Date = Date()
    @State private var txtMemo: String = ""
    @State private var isCategoryView: Bool = false
    @State private var selectionFoodCatrgory: FoodCategoryItem = FoodCategoryItem()
    
    
    @State var name: String = ""
    @State var category: String = ""
    @State var amount: String = ""
    @State var purchasedate: Date = Date()
    @State var expiredate: Date = Date()
    
    @State private var isError: Bool = false
    @State private var errorMessag: String = ""

    var foodCategoryList: FoodCategoryList?
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 24) {
                    ImputFieldView(text: $text).padding(.top)
                    
                    Text("Category")
                        .font(.title3)
                        .bold()
                    NavigationLink(destination: CategoryListView(selectionCategory: $selectionFoodCatrgory), isActive: $isCategoryView) {
                        Button {
                            isCategoryView.toggle()
                        } label: {
                            HStack{
                                Text( selectionFoodCatrgory.icon ?? "")
                                Text(LocalizedStringKey(selectionFoodCatrgory.name ?? ""))
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .overlay(content: {
                                        Capsule().stroke(Color.gray, lineWidth: 1)
                                    })
                                    
                            }
                        }
                    }
                    
                    ImputFieldView(headerTitle: "Amount", placeHolder: "Enter Amount", text: $quntity)
                        .keyboardType(.numberPad)
                    
                    Toggle("Purchase Date", isOn: $isPurchePickerOn)
                        .font(.title3)
                        .bold()
                        .tint(Color(userSetting.selectionThem.themColor))
                    
                    if isPurchePickerOn {
                        DatePicker("", selection: Binding<Date>(get: {self.purchesDate}, set: {self.purchesDate = $0}), displayedComponents: .date)
                    }
                    
                    Toggle("Expire Date", isOn: $isExpirePickerOn)
                        .font(.title3)
                        .bold()
                        .tint(Color(userSetting.selectionThem.themColor))
                    
                    if isExpirePickerOn {
                        DatePicker("", selection: Binding<Date>(get: {self.expireDate}, set: {self.expireDate = $0}), displayedComponents: .date)
                    }
                    
                    Button {
                        if text.isEmpty {
                            self.errorMessag = "Please enter category name."
                            isError = true
                        }else if quntity.isEmpty {
                            self.errorMessag = "Please enter category quntity."
                            isError = true
                        }else {
                            self.saveCategory()
                        }
                    } label: {
                        Text("Save Category")
                            .font(.title3)
                            .foregroundColor(.black)
                            .bold()
                            .frame(maxWidth: .infinity, minHeight: 60)
                    }
                    .background(Color(userSetting.selectionThem.themColor))
                    .clipShape(Capsule())
                    
                    if foodCategoryList != nil {
                        Button {
                            self.deleteCategory()
                        } label: {
                            Text("Delete Category")
                                .font(.title3)
                                .foregroundColor(.black)
                                .bold()
                                .frame(maxWidth: .infinity, minHeight: 60)
                        }
                        .background(Color(userSetting.selectionThem.themColor))
                        .clipShape(Capsule())

                    }
                   
                }
                .padding(.horizontal, 10)
            }
            .scrollDismissesKeyboard(.immediately)
        }
        .onAppear {
            if foodCategoryList != nil {
                self.text = foodCategoryList?.name ?? ""
                self.selectionFoodCatrgory = foodCategoryList?.categoryItem ?? FoodCategoryItem()
                self.quntity = String(foodCategoryList?.quntity ?? 0.0)
                self.purchasedate = foodCategoryList?.purchasedate ?? Date()
                self.expiredate = foodCategoryList?.expiredate ?? Date()
            }else {
                self.selectionFoodCatrgory = FoodCategoryItem.arrFoodCategoryItem.first ?? FoodCategoryItem()
            }
            
        }
        .alert(isPresented: $isError) {
            Alert(title: Text(LocalizedStringKey("Food Category List")), message: Text(LocalizedStringKey(errorMessag)), dismissButton: .default(Text(LocalizedStringKey("Ok"))))
        }
    }
    
    func saveCategory(){
        let foodCategoryData = FoodCategoryList(context: viewContext)
        foodCategoryData.id = UUID()
        foodCategoryData.name = text
        foodCategoryData.category = selectionFoodCatrgory.name
        foodCategoryData.quntity = Double(quntity) ?? 0.0
        foodCategoryData.purchasedate = purchesDate
        foodCategoryData.expiredate = expireDate
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func deleteCategory(){
        if let editCategory = foodCategoryList {
            self.viewContext.delete(editCategory)
            DispatchQueue.main.async {
                do{
                    try self.viewContext.save()
                    presentationMode.wrappedValue.dismiss()
                }catch {
                    let error = error as NSError
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        }
    }
}




struct ImputFieldView: View {
    @State var headerTitle:String = "Name"
    @State var placeHolder: String = "Enter Name"
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(headerTitle))
                .font(.title3)
                .bold()
            TextField(LocalizedStringKey(placeHolder), text: $text)
                .font(.title3)
                .submitLabel(.done)
                .padding(.leading, 8)
                .frame(height: 50)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(12)
        }
    }
}





