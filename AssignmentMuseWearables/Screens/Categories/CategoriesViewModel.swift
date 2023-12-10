//
//  CategoriesViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import Foundation
class CategoriesViewModel:ObservableObject{
    let networkManager = NetworkManager()
    let offlineManager = OfflineManager()
    
    
    
    @Published var categories:[CategoriesModel] = []
    
    func getCategories(){
        
        if NetworkMonitor.shared.isConnected {
            guard let url = URL(string: "http://ec2-15-207-119-97.ap-south-1.compute.amazonaws.com:3000/router/get/all/categories") else {
                return
            }
            networkManager.fetchRequest(type: [CategoriesModel].self, url: url){ result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.categories = data
                    }
                    DispatchQueue(label: "", qos: .background).async {
                        self.offlineManager.saveCategoriesData(data: self.categories)
                   
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        } else {
            self.categories = offlineManager.getCategoriesData()
        }
    }
}
