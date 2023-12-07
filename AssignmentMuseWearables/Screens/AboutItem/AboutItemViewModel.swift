//
//  AboutItemViewModel.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import Foundation


class AboutItemViewModel: ObservableObject {
    @Published var item:CategoryModel
    init(item: CategoryModel) {
        self.item = item
    }
}
