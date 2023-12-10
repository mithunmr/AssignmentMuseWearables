//
//  Cart.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import SwiftUI

struct Cart: View {
    @ObservedObject var cartViewModel:CartViewModel = CartViewModel()
  
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ScrollView{
                        ForEach(cartViewModel.cartItems,id:\.self) { cartItem in
                            CategoryItem(categoryItem: cartItem.item,quantity: cartItem.quantity)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color("#E9E4E4"))
                            
                        }
                    }
                    Spacer()
                    Button {
                        
                    }label: {
                        Label("CHECK OUT",image: "WhiteCart")
                            .font(.system(size: 15,weight: .semibold))
                    }
                    .frame(width: geometry.size.width-30,height: 46)
                    .background(Color("OrderNow"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.top)
               
                
            }.onAppear{
                cartViewModel.loadCartItem()
            }
        }.navigationTitle("Cart")
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}
