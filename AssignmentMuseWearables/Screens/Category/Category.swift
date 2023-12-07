//
//  Category.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

struct Category: View {
    @ObservedObject var categoryViewModel:CategoryViewModel
    @State var searchText: String = ""
     
    init(categoryViewModel: CategoryViewModel = CategoryViewModel(), categoryType:String) {
        self.categoryViewModel = categoryViewModel
        self.categoryViewModel.categoryType = categoryType
     
    }

    let adaptiveColumn = [GridItem(.adaptive(minimum: 170),alignment: .top)]
    var body: some View {
        NavigationView {
            
            GeometryReader { geometry in
                
                VStack {
                    //Search Bar
                    SearchBar(searchText: $searchText)
                        .padding()
                    
                    //List Categories
                    ScrollView {
                        
                        ForEach(categoryViewModel.category, id: \.self){ categoryItem in
                            
                            NavigationLink(destination: AboutItem(item: categoryItem)){
                                CategoryItem(categoryItem: categoryItem)
                            }
                        }
                    }
                }
            }
            .background(Color("#EEEEEE"))
            .navigationTitle(categoryViewModel.categoryType)
            .onAppear {
              categoryViewModel.fetchCategory()
            }
            //toolbar
        }
    }
}

struct Category_Previews: PreviewProvider {
    static var previews: some View {
        Category(categoryType: "VEGETABLE")
    }
}








//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        print("Help tapped!")
//                    }label: {
//                        Image("Back")
//                    }
//                }
//            }
