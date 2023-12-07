//
//  CategoryViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import Foundation
class CategoryViewModel:ObservableObject{
    @Published var category:[CategoryModel] = [CategoryModel(typeID: 1, typeName: "Tomato", description: "Red", thumbnailImage: "", sliderImages: [], pricePerPiece: 12.0, weightPerPiece: 10.0)]

    let networkManager = NetworkManager()
    var categoryType: String="VEGETABLE"
    
   
    func fetchCategory() {
        guard let url = URL(string: "http://ec2-15-207-119-97.ap-south-1.compute.amazonaws.com:3000/router/get/category/\(self.categoryType)") else {
            return
        }
 
        networkManager.fetchRequest(type: [CategoryModel].self, url: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.category = data
                }
            case .failure(let failure):
                print(failure)
            }
        }
 
    }
}
