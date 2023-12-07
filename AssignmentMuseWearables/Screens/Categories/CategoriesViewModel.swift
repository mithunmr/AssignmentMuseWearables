//
//  CategoriesViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import Foundation
class CategoriesViewModel:ObservableObject{
    let networkManager = NetworkManager()
    @Published var categories:[CategoriesModel] = [CategoriesModel(categoryID: 1, categoryType: "VEGRTABLE", categoryName: "Vegetable", categoryImage: "BostonLettuce", totalItems: 2)]
    
    
    func getCategories(){
        guard let url = URL(string: "http://ec2-15-207-119-97.ap-south-1.compute.amazonaws.com:3000/router/get/all/categories") else {
            return
        }
        networkManager.fetchRequest(type: [CategoriesModel].self, url: url){ result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.categories = data
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
