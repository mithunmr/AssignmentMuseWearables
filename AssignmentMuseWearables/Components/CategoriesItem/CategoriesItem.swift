//
//  CategoriesItem.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI


struct CategoriesItem: View {
    
    var categoriesItem:CategoriesModel
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment:.leading) {
              if  NetworkMonitor.shared.isConnected{
                    AsyncImage(
                        url: URL(string: categoriesItem.categoryImage),
                
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width,height: 103)
                        },
                        placeholder: {
                            ProgressView()
                                .frame(width: geometry.size.width,height: 103)
                        }
                    )
           
                }else{
                    Image(uiImage: UIImage(data: categoriesItem.offlineImageData!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width,height: 103)
                }
                   
            
                Text(categoriesItem.categoryName)
                    .font(.system(size: 18,weight: .semibold))
                    .padding(.leading)
                Text("(+\(categoriesItem.totalItems))")
                    .font(.system(size: 10,weight: .light))
                    .padding(.leading)
                    .padding(.top,5)
            }
        }.frame(width: 170,height:200)
            .background(.white)
            .cornerRadius(12)
            .foregroundColor(.black)
    }
   
}

struct CategoriesItem_Previews: PreviewProvider {

    static var previews: some View {
        CategoriesItem(categoriesItem:  CategoriesModel(categoryID: 1, categoryType: "veg", categoryName: "veg", categoryImage: "", totalItems: 1))
    }
}
