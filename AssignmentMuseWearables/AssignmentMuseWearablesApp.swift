//
//  AssignmentMuseWearablesApp.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

@main
struct AssignmentMuseWearablesApp: App {
    
    init() {
        NetworkMonitor.shared.startMonitoring()
    }
  
    var body: some Scene {
        WindowGroup {
           Home()
        }
    }
}
