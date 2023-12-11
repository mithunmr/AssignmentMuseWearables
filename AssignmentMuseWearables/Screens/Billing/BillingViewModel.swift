//
//  BillingViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import Foundation
import SwiftUI
import Stripe


enum BillingFields:String,CaseIterable {
    case name = "Name"
    case cardNumber = "Card Number"
    case expiryDate = "Expiry Date"
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
        case .cardNumber,.cvc,.expiryDate:
            self.inputType = .numberPad
        case .name:
            self.inputType = .alphabet
        }
    }
}

class BillingViewModel: ObservableObject {
    private var paymentMethodParams:STPPaymentMethodParams = STPPaymentMethodParams()
    let paymentGatewayController = PaymentGatewayController()
    
    @Published var billingFileds:[BillingFieldmodule] = BillingFields.allCases.map({
        switch $0{
        case .cvc:
            return BillingFieldmodule(title: $0.rawValue, type: $0, hint: true, hintImage: "Hint")
        case .name, .cardNumber, .expiryDate:
            return BillingFieldmodule(title: $0.rawValue, type: $0, hint: false, hintImage: "")
        }
    })
    
    
    func updateValue(value:String,fieldType:BillingFields){
        self.billingFileds.forEach{
            if $0.type == fieldType{
                $0.value = value
            }
        }
    }
    
    private  func prePareCardDetails(){
        paymentMethodParams.type = .card
        let cardParams = STPPaymentMethodCardParams()
        billingFileds.forEach({
            switch $0.type{
            case .name:
                break
            case .cardNumber:
                cardParams.number = $0.value
            case .expiryDate:
                cardParams.expMonth = Int($0.value.split(separator: "/")[0]) as NSNumber?
                cardParams.expYear = Int($0.value.split(separator: "/")[1]) as NSNumber?
            case .cvc:
                cardParams.cvc = $0.value
            }
        })
        paymentMethodParams.card = cardParams
    }
    
    func pay(complition:@escaping (STPPaymentHandlerActionStatus)->Void) {
        if let checkOutData = PaymentManager.shared.checkOutResponse {
            prePareCardDetails()
            STPAPIClient.shared.publishableKey = checkOutData.publishableKey
            let paymnetIntentParam = STPPaymentIntentParams(clientSecret: checkOutData.paymentIntent)
            paymnetIntentParam.paymentMethodParams =  paymentMethodParams
            paymentGatewayController.submitPayment(intent:paymnetIntentParam){(status, intent, error) in
                guard error != nil else {
                    complition(.failed)
                    return
                }
                complition(status)
                        
            }
        }
    }
}
