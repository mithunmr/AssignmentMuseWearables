//
//  AppModule.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 10/12/23.
//

import Foundation

class AppModule {
    private init(){

    }
    static var shared = AppModule()
    let cartManager = CartManager()
    
    
}
