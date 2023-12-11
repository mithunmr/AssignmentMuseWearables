//
//  PaymentManager.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation
class PaymentManager {
    private init(){}
    static var shared = PaymentManager()
    var checkOutResponse:CheckOutResponseModel?
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
}

struct CheckOutResponseModel:Codable{
    var publishableKey:String
    var ephemeralKey:String
    var customer:String
    var paymentIntent:String
}
