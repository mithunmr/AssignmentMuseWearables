//
//  CategoryItem.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

struct CategoryItem: View {
    var categoryItem:CategoryModel
    var quantity:Int?
    var body: some View {
        GeometryReader{ geometry in
            HStack(alignment: .top) {
                
                if NetworkMonitor.shared.isConnected{
                    AsyncImage(
                        url: URL(string: categoryItem.thumbnailImage),
                
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 175,height: 150)
                                .cornerRadius(10)
                        },
                        placeholder: {
                            ProgressView()
                                .frame(width: 175,height: 150)
                                .cornerRadius(10)
                        }
                    )
                } else {
                    Image(uiImage: UIImage(data: categoryItem.offlineImage!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 175,height: 150)
                        .cornerRadius(10)
                }
                    
                VStack (alignment:.leading){
                    Text(categoryItem.typeName)
                        .font(.system(size: 25,weight: .regular))
                    HStack {
                        Text("\(categoryItem.pricePerPiece,specifier: "%.1f")")
                            .font(.system(size: 15,weight: .regular))
                        Text("$/Kg ")
                            .font(.system(size: 15,weight: .regular))
                       
                    }.padding(.top,5)
                    if let quantity = quantity {
                        Text("Quantity : \(quantity) ")
                            .font(.system(size: 15,weight: .regular))
                    }
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
