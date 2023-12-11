//
//  PaymentGatewayController.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation
import Stripe
import UIKit

class PaymentGatewayController:UIViewController {
    func submitPayment(intent:STPPaymentIntentParams,complition:@escaping (STPPaymentHandlerActionStatus,STPPaymentIntent?,NSError?)->Void){
        STPPaymentHandler.shared().confirmPayment(intent, with: self){ (status, intent, error) in
           complition(status, intent, error)
        }
    }
}


extension PaymentGatewayController:STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        self
    }
}

