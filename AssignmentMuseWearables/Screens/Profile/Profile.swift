//
//  Profile.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var text:String = ""
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
    
            
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
