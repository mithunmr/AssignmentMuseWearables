//
//  CartModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation

struct CartModel:Hashable {
    var item:CategoryModel
    var quantity:Int
}


struct CheckOutModel:Codable{
    var amount:Int
    var currency:String
}


