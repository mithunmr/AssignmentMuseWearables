//
//  AddressViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import Foundation
import SwiftUI

enum DeliveryType:Hashable {
    case walking
    case bike
    case drone
}

class DevliveryOption {
 
    var deliveryType:DeliveryType
    var image:String
    var title:String
    var isSlected:Bool
    init(deliveryType: DeliveryType, image: String, title: String, isSlected: Bool) {
        self.deliveryType = deliveryType
        self.image = image
        self.title = title
        self.isSlected = isSlected
    }

}

class AddressViewModel:ObservableObject {
    
   @Published var deliveryOptions :[DevliveryOption] = [
        DevliveryOption(deliveryType: .walking, image: "Walking", title: "I’ll pick it up Myself", isSlected: true),
        DevliveryOption(deliveryType: .bike, image: "Bike", title: "By Courier", isSlected: false),
        DevliveryOption(deliveryType: .drone, image: "Drone", title: "By Drone", isSlected: false)
    ]
    
    
    func selectDevliveryOption(deliveryType:DeliveryType) {
        self.deliveryOptions.forEach{ $0.isSlected = ($0.deliveryType == deliveryType) ? true : false}
        
        
    }
    
}
