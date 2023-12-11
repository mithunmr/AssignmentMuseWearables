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
                VStack(alignment: .center) {
                    ScrollView{
                        ForEach(cartViewModel.cartItems,id:\.self) { cartItem in
                            CategoryItem(categoryItem: cartItem.item,quantity: cartItem.quantity)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color("#E9E4E4"))
                            
                        }
                    }
                    Spacer()
                    Text("Total: \(cartViewModel.totalPrice,specifier: "%.2f")$")
                        .font(.largeTitle)
                        .padding()
                    NavigationLink(isActive: $cartViewModel.goToBilling, destination: {Billing()}, label: {
                        Button {
                            cartViewModel.CheckOut()
                        }label: {
                            Label("CHECK OUT",image: "WhiteCart")
                                .font(.system(size: 15,weight: .semibold))
                        }
                       
                        .frame(width: geometry.size.width*0.7 ,height: 46)
                        .background(Color("OrderNow"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    })
                 
                
                }
                .frame(width: geometry.size.width)
                .padding(.top)
            }.onAppear{
                cartViewModel.loadCartItem()
            }.background(Color("#EEEEEE"))
        }.navigationTitle("Cart")
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}
