//
//  AboutItem.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

struct AboutItem: View {
    
    @ObservedObject var aboutViewModel:AboutItemViewModel
    
    init(item:CategoryModel) {
        self.aboutViewModel = AboutItemViewModel(item: item)
    }
   
    var body: some View {
        NavigationStack {
            
            GeometryReader { geometryReader in
                ZStack(alignment: .top) {
                    Image("BostonLettuce")
              
                    VStack(alignment:.leading){
                        VStack(alignment: .leading){
                            Text(aboutViewModel.item.typeName)
                                .font(.system(size: 30,weight: .semibold))
                                .padding(.top,30)
                            
                            
                            HStack{
                                Text("\(aboutViewModel.item.pricePerPiece)")
                                     .font(.system(size: 27,weight: .semibold))
                                     
                                Text("$/Piece")
                                    .font(.system(size: 30,weight: .light))
                            }
                            .padding(.vertical,2)
                            Text("~\(aboutViewModel.item.weightPerPiece) gr/ piece")
                                .font(.system(size: 17,weight: .semibold))
                                .foregroundColor(.green)
                                .padding(.vertical,2)
                            Text("Spain")
                                .font(.system(size: 22,weight: .semibold))
                                .padding(.vertical,2)
                            
                            Text(aboutViewModel.item.description)
                                .font(.body)
                                .padding(.vertical,2)
                            
                            
                            HStack {
                                Button{
                                    
                                }label: {
                                    Image("Like")
                                        
                                }
                                .frame(width: 80,height: 46)
                                .background(.white)
                                .cornerRadius(12)
                                
                                NavigationLink(destination: Billing(), label: {   Label("ADD TO CART",image: "WhiteCart")
                                    .font(.system(size: 15,weight: .semibold))}).frame(width: 260,height: 46)
                                    .background(Color("OrderNow"))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                                            
                            }.padding(.vertical)
                        }.padding()
                        
                    } .frame(width: geometryReader.size.width, height: geometryReader.size.height*0.6,alignment: .top)
                        .background(Color("#EEEEEE"))
                        .cornerRadius(40)
                        .offset(x: -10,y: geometryReader.size.height*0.4)
                }
                .frame(height: geometryReader.size.height,alignment: .top)
            }
            .ignoresSafeArea()
     
        }
    }
}

struct AboutItem_Previews: PreviewProvider {
    static var previews: some View {
        AboutItem(item: CategoryModel(typeID: 1, typeName: "VEGETABLE", description: "GOOD", thumbnailImage: "Card", sliderImages: [], pricePerPiece: 12.0, weightPerPiece: 12.0))
    }
}
