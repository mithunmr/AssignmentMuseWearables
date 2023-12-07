//
//  BillingViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import Foundation
import SwiftUI


enum BillingFields:String,CaseIterable {
    case name = "Name"
    case cardNumber = "Card Number"
    case ExpiryDate = "Expiry Date"
    case cvc = "CVC"
}


class BillingFieldmodule {
    var title:String
    var type:BillingFields
    var inputType:UIKeyboardType
    var hint:Bool
    var hintImage:String
    var value = ""
    
    init(title: String, type: BillingFields, hint: Bool, hintImage: String) {
        self.title = title
        self.type = type
        self.hint = hint
        self.hintImage = hintImage
        switch self.type  {
        case .cardNumber,.cvc,.ExpiryDate:
            self.inputType = .numberPad
        case .name:
            self.inputType = .alphabet
            
        }
    }
    
}

class BillingViewModel:ObservableObject{
    @Published var billingFileds:[BillingFieldmodule] = BillingFields.allCases.map({
        switch $0{
        case .cvc:
           return BillingFieldmodule(title: $0.rawValue, type: $0, hint: true, hintImage: "Hint")
        case .name, .cardNumber, .ExpiryDate:
             return BillingFieldmodule(title: $0.rawValue, type: $0, hint: false, hintImage: "")
        }
    })
    
}
