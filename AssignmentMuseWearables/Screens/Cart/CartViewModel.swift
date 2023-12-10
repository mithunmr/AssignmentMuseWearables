//
//  CartViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation
class CartViewModel:ObservableObject {
    
    @Published var cartItems:[CartModel] = []
    
    init() {
        loadCartItem()
    }
    
    func loadCartItem(){
        self.cartItems = AppModule.shared.cartManager.cartItems
 
    }
    
    func removeItem(itemName:String){
        AppModule.shared.cartManager.deleteItemFromCart(itemName: itemName)
    }
  

}
