//
//  HomeViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 11/12/23.
//

import Foundation

enum HomePopSheet{
    case wellcome
    case thankyou
}
class HomeViewModel:ObservableObject{
    @Published var homeData:HomeModel?
    @Published var sheetType:HomePopSheet
    init(sheetType: HomePopSheet) {
        self.sheetType = sheetType
        self.setUpSheet(sheetType: self.sheetType)
    }
    
    func setUpSheet(sheetType:HomePopSheet) {
        switch sheetType {
        case .wellcome:
            homeData = HomeModel(title: "Non-Contact Deliveries", discription: "When placing an order, select the option “Contactless delivery” and the courier will leave your order at the door.", greenButtonTitle: "ORDER NOW ", witeButtonTitle: "Dismiss")
        case .thankyou:
            homeData = HomeModel(title: "Thank You For shopping with us", discription: "", greenButtonTitle: "ORDER MORE ", witeButtonTitle: "CLOSE")
        }
    }
    
    func close_Dismiss(){
        setUpSheet(sheetType: .wellcome)
    }
}
