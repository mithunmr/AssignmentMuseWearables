//
//  CartManager.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation
class CartManager:ObservableObject {
   @Published var cartItems:[CartModel] = []
    
    func  addItemToCart(cartItem:CategoryModel){
        if !cartItems.contains(where: {$0.item.typeName == cartItem.typeName}){
            cartItems.append(CartModel(item: cartItem, quantity: 1))
        }else{
            print("item already exist")
        }
    }
    
    func deleteItemFromCart(itemName:String){
        for (index,cartItem) in cartItems.enumerated() where cartItem.item.typeName == itemName {
            cartItems.remove(at: index)
        }
    }
    
    func clearCart(){
        cartItems.removeAll()
    }
}
