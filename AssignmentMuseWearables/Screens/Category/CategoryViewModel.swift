//
//  CategoryViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import Foundation
class CategoryViewModel:ObservableObject{
    @Published var category:[CategoryModel] = []
    
    let networkManager = NetworkManager()
    let offlineManager = OfflineManager()
    var categoryType: String="VEGETABLE"
    
    
    
    func fetchCategory() {
        guard let url = URL(string: "http://ec2-15-207-119-97.ap-south-1.compute.amazonaws.com:3000/router/get/category/\(self.categoryType)") else {
            return
        }
        if NetworkMonitor.shared.isConnected {
            networkManager.fetchRequest(type: [CategoryModel].self, url: url) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.category = data
                    }
                    DispatchQueue(label: "", qos: .background).async {
                        self.offlineManager.saveCategoryData(data: self.category,theCategoryName: self.categoryType)
                                            }
                case .failure(let failure):
                    print(failure)
                }
            }
            
        } else {
            self.category = offlineManager.getCategoryData(theCategoryName: self.categoryType)
        }
    }
}
