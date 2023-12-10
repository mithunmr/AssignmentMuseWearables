//
//  SQLiteCategoryCommands.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 09/12/23.
//

import Foundation
import SQLite
import SQLite3
class SQLiteCategoryCommands {
    static var table = Table("Category")
    static let typeID = Expression<Int>("typeID")
    static let categoryName = Expression<String>("categoryName")
    static let typeName = Expression<String>("typeName")
    static let description = Expression<String>("description")
    static let thumbnailImage = Expression<String>("thumbnailImage")
    static let sliderImages = Expression<String>("sliderImages")
    
    static let pricePerPiece = Expression<Double>("pricePerPiece")
    static let weightPerPiece = Expression<Double>("weightPerPiece")
    static let offlineImage = Expression<Data>("offlineImageData")
    
    static func createTable()->String{
        guard let dataBase = SQLiteDatabase.sharedInstance.database else {
            print("Failed to Connect DB")
            return "Failed to Connect DB"
        }
        
        do {
            try dataBase.run(table.create(ifNotExists: true){ table in
                table.column(typeID)
                table.column(categoryName)
                table.column(typeName,primaryKey: true)
                table.column(description)
                table.column(thumbnailImage)
                table.column(sliderImages)
                table.column(pricePerPiece)
                table.column(weightPerPiece)
                    table.column(offlineImage)
            })
            return "Table Created"
        }catch {
            print("Table Already Creadted")
            return "Table Already Creadted"
        }
    }
    
    static func insertRow(category:[CategoryModel],theCategoryName:String){
        guard let dataBase = SQLiteDatabase.sharedInstance.database else {
            print("Failed to COnnect DB")
            return
        }
        do {
            for categoryItem in category {
                if let imageData = downloadImageData(urlText: categoryItem.thumbnailImage) {
                    do {
                        try dataBase.run(table.insert(
                            typeID <- categoryItem.typeID,
                            categoryName <- theCategoryName,
                            typeName <- categoryItem.typeName,
                            description <- categoryItem.description,
                            thumbnailImage <- categoryItem.thumbnailImage,
                            sliderImages <- categoryItem.sliderImages.joined(separator: ","),
                            pricePerPiece <- categoryItem.pricePerPiece,
                            weightPerPiece <- categoryItem.weightPerPiece,
                            offlineImage <- imageData
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
    
    static func updateRow(category: [CategoryModel],theCategoryName:String) {
        guard let dataBase = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            
            for categoryItem in category {
                if let imageData = downloadImageData(urlText: categoryItem.thumbnailImage) {
                    do {
                        try dataBase.run(table.insert(
                            typeID <- categoryItem.typeID,
                            categoryName <- theCategoryName,
                            typeName <- categoryItem.typeName,
                            description <- categoryItem.description,
                            thumbnailImage <- categoryItem.thumbnailImage,
                            sliderImages <- categoryItem.sliderImages.joined(separator: ","),
                            pricePerPiece <- categoryItem.pricePerPiece,
                            weightPerPiece <- categoryItem.weightPerPiece,
                            offlineImage <- imageData
                        ))
                    } catch {
                        print("Insert failed. \(error)")
                    }
                    
                } else {
                    print("failed to Download image data")
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

    
    static func presentRows(theCategoryName:String) -> [CategoryModel]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
 
        var categoryArray = [CategoryModel]()
        
    
        table = table.order(typeID.desc)
        
        do {
            for categoryItem in try database.prepare(table)  where categoryItem[categoryName] == theCategoryName {
                
                
                
                let typeID = categoryItem[typeID]
                let typeName = categoryItem[typeName]
                let description = categoryItem[description]
                let thumbnailImage = categoryItem[thumbnailImage]
                let sliderImages = categoryItem[sliderImages].split(separator: ",").map { String($0) }
                let pricePerPiece = categoryItem[pricePerPiece]
                let weightPerPiece = categoryItem[weightPerPiece]
                let offlineImage = categoryItem[offlineImage]
                let categoriesModel = CategoryModel(typeID: typeID, typeName: typeName, description: description, thumbnailImage: thumbnailImage, sliderImages: sliderImages, pricePerPiece: pricePerPiece, weightPerPiece: weightPerPiece,offlineImage: offlineImage)
                
   
                categoryArray.append(categoriesModel)
            }
        } catch {
            print("Present row error: \(error)")
        }
        return categoryArray
    }
}
