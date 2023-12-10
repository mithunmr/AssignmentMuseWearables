//
//  CategoryModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import Foundation
struct CategoryModel:Codable,Hashable {
    var typeID:Int
    var typeName:String
    var description:String
    var thumbnailImage:String
    var sliderImages:[String]
    var pricePerPiece:Double
    var weightPerPiece:Double
    var offlineImage:Data?
    
    private enum CodingKeys: String, CodingKey {
        case typeID,typeName,description,thumbnailImage,sliderImages,pricePerPiece,weightPerPiece
    }
}


//[
//  {
//    "typeID": 2,
//    "typeName": "Green Apple",
//    "description": "The Granny Smith, also known as a green apple or sour apple, is an apple cultivar that originated in Australia in 1868.[1] It is named after Maria Ann Smith, who propagated the cultivar from a chance seedling.",
//    "thumbnailImage": "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/green_apple1.jpg",
//    "sliderImages": [
//      "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/green_apple1.jpg",
//      "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/green_apple2.jpg"
//    ],
//    "pricePerPiece": 2,
//    "weightPerPiece": 200
//  },
//  {
//    "typeID": 2,
//    "typeName": "Red Apple",
//    "description": "An apple is a round, edible fruit produced by an apple tree (Malus domestica). Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus.",
//    "thumbnailImage": "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/apple1.jpg",
//    "sliderImages": [
//      "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/apple1.jpg",
//      "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/apple2.jpg"
//    ],
//    "pricePerPiece": 0.6,
//    "weightPerPiece": 150
//  }
//]
