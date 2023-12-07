//
//  Categories.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

struct Categories: View {
    @StateObject var categoriesViewModel = CategoriesViewModel()
    @State var searchText: String = ""
    let adaptiveColumn = [GridItem(.adaptive(minimum: 170),alignment: .top)]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                //Search Bar
                SearchBar(searchText: $searchText)
                    .padding()
                
                //List Categories
                ScrollView {
                    LazyVGrid(columns: adaptiveColumn, alignment: .leading,spacing: 10){
                        ForEach(categoriesViewModel.categories,id:\.self){ categoriesItem in
                            NavigationLink(destination: Category(categoryType: categoriesItem.categoryType)){
                                CategoriesItem(categoriesItem: categoriesItem)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,geometry.safeAreaInsets.bottom)
            }
            .onAppear{
                categoriesViewModel.getCategories()
            }
        }
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories(searchText: "")
    }
}
