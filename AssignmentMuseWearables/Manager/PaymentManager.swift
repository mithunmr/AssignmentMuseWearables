//
//  PaymentManager.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation
import Stripe
class PaymentManager {
    private init(){}
    static var shared = PaymentManager()
    var checkOutResponse:CheckOutResponseModel?
    private var paymentMethodParams:STPPaymentMethodParams = STPPaymentMethodParams()
    let paymentGatewayController = PaymentGatewayController()
    let BackendUrl = "http:/ec2-15-207-119-97.ap-south-1.compute.amazonaws.com:3000/start/payment"
    
    func checkOut(checkOutData:CheckOutModel, complition: @escaping (Bool)-> Void){
        let url = URL(string: PaymentManager.shared.BackendUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(checkOutData)
        DispatchQueue.main.async {
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = data,
                      let checkOutResponse = try?  JSONDecoder().decode(CheckOutResponseModel.self, from: data)
                else {
                    complition(false)
                    return
                }
                self.checkOutResponse = checkOutResponse
                
                complition(true)
            })
            task.resume()
        }
    }
    
    private  func prePareCardDetails(cardFields:[CardFieldmodule]) -> Bool{
        paymentMethodParams.type = .card
        let cardParams = STPPaymentMethodCardParams()
        cardFields.forEach({
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
        return true
    }
    
    
    func addCardDetails(cardFields:[CardFieldmodule],  complition:@escaping (Bool)->Void) {
       complition(prePareCardDetails(cardFields: cardFields))
        
    }
    
    func submitPayment(complition:@escaping (STPPaymentHandlerActionStatus)->Void){
        if let checkOutData = PaymentManager.shared.checkOutResponse {
            STPAPIClient.shared.publishableKey = checkOutData.publishableKey
            let paymnetIntentParam = STPPaymentIntentParams(clientSecret: checkOutData.paymentIntent)
            paymnetIntentParam.paymentMethodParams =  paymentMethodParams
            paymentGatewayController.submitPayment(intent:paymnetIntentParam){(status, intent, error) in
                complition(status)
            }
        }
    }
}

struct CheckOutResponseModel:Codable{
    var publishableKey:String
    var ephemeralKey:String
    var customer:String
    var paymentIntent:String
}
