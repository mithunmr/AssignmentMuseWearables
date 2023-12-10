//
//  SQLiteCommands.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 08/12/23.
//

import Foundation
import SQLite
import SQLite3



class SQLiteCategoriesCommands {
    
    static var table = Table("Categories")
    static let categoryID = Expression<Int>("categoryID")
    static let categoryType = Expression<String>("categoryType")
    static let categoryName = Expression<String>("categoryName")
    static let categoryImage = Expression<String>("categoryImage")
    static let totalItems = Expression<Int>("totalItems")
    static let offlineImageData = Expression<Data>("offlineImageData")
    
    static func createTable()->String{
        guard let dataBase = SQLiteDatabase.sharedInstance.database else {
            print("Failed to Connect DB")
            return "Failed to Connect DB"
        }
        
        do {
            try dataBase.run(table.create(ifNotExists: true){ table in
                table.column(categoryID, primaryKey: true)
                table.column(categoryType)
                table.column(categoryName)
                table.column(categoryImage)
                table.column(totalItems)
                table.column(offlineImageData)
            })
            return "Table Created"
        }catch {
            print("Table Already Creadted")
            return "Table Already Creadted"
        }
    }
    
    static func insertRow(categories:[CategoriesModel]){
        guard let dataBase = SQLiteDatabase.sharedInstance.database else {
            print("Failed to COnnect DB")
            return
        }
        do {
            for category in categories {
                if let imageData = downloadImageData(urlText: category.categoryImage) {
                    do {
                        try dataBase.run(table.insert(
                            categoryID <- category.categoryID,
                            categoryType <- category.categoryType,
                            categoryName <- category.categoryName,
                            categoryImage <- category.categoryImage,
                            totalItems <- category.totalItems,
                            offlineImageData <- imageData
                        ))
                    } catch {
                        print("Insert failed. \(error)")
                    }
                    
                } else {
                    print("failed to Download image data")
                }
            }
            
        } catch let Result.error(message , code, statement) where code == SQLITE_CONSTRAINT {
            print("Failed To insert Row : \(message) , in \(String(describing: statement))")
            
        } catch {
            print("Failed To insert Row \(error)")
        }
    }
    
    static func updateRow(categories: [CategoriesModel]) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            for category in categories {
                let contact = table.filter(categoryID == category.categoryID).limit(1)
                if try database.run(contact.update(
                    categoryID <- category.categoryID,
                    categoryType <- category.categoryType,
                    categoryName <- category.categoryName,
                    categoryImage <- category.categoryImage,
                    totalItems <- category.totalItems
                )) > 0 {
                    print("Updated contact")
                } else {
                    print("Could not update contact: contact not found")
                }
            }
          
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Update row faild: \(message), in \(String(describing: statement))")
        } catch let error {
            print("Updation failed: \(error)")
        }
    }
    
    static  func downloadImageData(urlText:String) -> Data? {
          guard let imageURL = URL(string: urlText) else {
              return nil
          }
          // Download image data
          if let imageData = try? Data(contentsOf: imageURL) {
              // Save image data to SQLite database
              print("\n\n \(imageURL) \n\n")
             return imageData
          }else{
              return nil
          }
      }

    
    static func presentRows() -> [CategoriesModel]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        // Contact Array
        var categoriesArray = [CategoriesModel]()
        
        // Sorting data in descending order by ID
        table = table.order(categoryID.desc)
        
        do {
            for categoriesItem in try database.prepare(table) {
                
                
                let categoryID = categoriesItem[categoryID]
                let  categoryType = categoriesItem[categoryType]
                let  categoryName  = categoriesItem[categoryName]
                let  categoryImage = categoriesItem[categoryImage]
                let  totalItems = categoriesItem[totalItems]
                let  offlineImageData = categoriesItem[offlineImageData]
                
                
                let categoriesModel = CategoriesModel(categoryID: categoryID, categoryType: categoryType, categoryName:categoryName, categoryImage: categoryImage, totalItems: totalItems,offlineImageData: offlineImageData)
                
                // Add object to an array
                categoriesArray.append(categoriesModel)
            }
        } catch {
            print("Present row error: \(error)")
        }
        return categoriesArray
    }
}
