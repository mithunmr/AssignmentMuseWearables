//
//  CategoriesModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import Foundation

struct CategoriesModel: Codable, Hashable {
    var categoryID:Int
    var categoryType:String
    var categoryName:String
    var categoryImage:String
    var totalItems:Int
    var offlineImageData:Data?
    
    
    private enum CodingKeys: String, CodingKey {
           case categoryID, categoryType, categoryName , categoryImage, totalItems
       }

}

//
//[
//  {
//    "categoryID": 1,
//    "categoryType": "VEGETABLE",
//    "categoryName": "Vegetables",
//    "categoryImage": "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/vegetables.jpg",
//    "totalItems": 1
//  },
//  {
//    "categoryID": 2,
//    "categoryType": "FRUIT",
//    "categoryName": "Fruits",
//    "categoryImage": "https://museassignment.s3.ap-south-1.amazonaws.com/ios/cartassignment/fruits.jpg",
//    "totalItems": 2
//  }
//]
