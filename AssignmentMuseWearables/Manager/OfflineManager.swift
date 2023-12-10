//
//  OfflineManager.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 08/12/23.
//

import Foundation


class OfflineManager {
 
    func saveCategoriesData(data:[CategoriesModel]) {
        let result =  SQLiteCategoriesCommands.createTable()
        if result == "Table Created" {
            SQLiteCategoriesCommands.insertRow(categories: data)
        }else{
            SQLiteCategoriesCommands.updateRow(categories: data)
        }
    }
    
    func getCategoriesData()->[CategoriesModel] {
        SQLiteCategoriesCommands.presentRows() ?? []
    }
    
    
    func saveCategoryData(data:[CategoryModel],theCategoryName:String) {
        let result =  SQLiteCategoryCommands.createTable()
        if result == "Table Created" {
            SQLiteCategoryCommands.insertRow(category: data,theCategoryName: theCategoryName)
        }else{
            SQLiteCategoryCommands.updateRow(category: data,theCategoryName: theCategoryName)
        }
    }
    
    func getCategoryData(theCategoryName: String)->[CategoryModel] {
        SQLiteCategoryCommands.presentRows(theCategoryName: theCategoryName) ?? []
    }
    
    
    
    
    
}
