//
//  BillingViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import Foundation
import SwiftUI



enum CardFields:String,CaseIterable {
    case name = "Name"
    case cardNumber = "Card Number"
    case expiryDate = "Expiry Date"
    case cvc = "CVC"
}


class CardFieldmodule {
    var title:String
    var type:CardFields
    var inputType:UIKeyboardType
    var hint:Bool
    var hintImage:String
    var value = ""
    
    init(title: String, type: CardFields, hint: Bool, hintImage: String) {
        self.title = title
        self.type = type
        self.hint = hint
        self.hintImage = hintImage
        switch self.type  {
        case .cardNumber,.cvc,.expiryDate:
            self.inputType = .numberPad
        case .name:
            self.inputType = .alphabet
        }
    }
}

class CardViewModel: ObservableObject {
   
    
    @Published var cardFileds:[CardFieldmodule] = CardFields.allCases.map({
        switch $0{
        case .cvc:
            return CardFieldmodule(title: $0.rawValue, type: $0, hint: true, hintImage: "Hint")
        case .name, .cardNumber, .expiryDate:
            return CardFieldmodule(title: $0.rawValue, type: $0, hint: false, hintImage: "")
        }
    })
    @Published var goToAddress:Bool = false
    
    
    func updateValue(value:String,fieldType:CardFields){
        self.cardFileds.forEach{
            if $0.type == fieldType{
                $0.value = value
            }
        }
    }
    
    
    func addCard(){
        PaymentManager.shared.addCardDetails(cardFields: cardFileds){ result in
            if result {
                self.goToAddress = true
            }
        }
    }
}
