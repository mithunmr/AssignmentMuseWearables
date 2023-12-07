//
//  CategoryItem.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

struct CategoryItem: View {
    var categoryItem:CategoryModel
    var body: some View {
        GeometryReader{ geometry in
            HStack(alignment: .top){
                Image("vegetables")
                    .resizable()
                    .frame(width: 175,height: 150)
                    .cornerRadius(10)
                VStack (alignment:.leading){
                    Text(categoryItem.typeName)
                        .font(.system(size: 25,weight: .regular))
                    HStack {
                        Text("12")
                            .font(.system(size: 15,weight: .regular))
                        Text("$/Kg ")
                            .font(.system(size: 15,weight: .regular))
                    }.padding(.top,5)
                }.padding()
            }.foregroundColor(.black)
          
          
        }
        .frame(height: 150)
            .background(Color("#E9E4E4"))
            .cornerRadius(10)
            .padding(.vertical,2)
            .padding(.horizontal)
          
         
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        Category(categoryType: "")
    }
}