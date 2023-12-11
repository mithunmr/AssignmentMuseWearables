//
//  CartViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation
class CartViewModel:ObservableObject {
    
    @Published var cartItems:[CartModel] = [] {
        didSet {
            totalPrice = cartItems.reduce(0, {$0 + (($1.item.pricePerPiece) * Double($1.quantity))})
        }
    }
    @Published var totalPrice:Double = 0.0
    @Published var goToCard:Bool = false
    init() {
        loadCartItem()
    }
    
    func loadCartItem(){
        self.cartItems = AppModule.shared.cartManager.cartItems
 
    }
    
    func removeItem(itemName:String){
        AppModule.shared.cartManager.deleteItemFromCart(itemName: itemName)
    }
  
    func CheckOut(){
        let theCheckOutData = CheckOutModel(amount:Int(totalPrice), currency: "usd")
        PaymentManager.shared.checkOut(checkOutData:theCheckOutData){result in
            DispatchQueue.main.async {
                if result {
                    self.goToCard = true
                }else{
                    self.goToCard = false
                }
            }
        }
    }
}


extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
