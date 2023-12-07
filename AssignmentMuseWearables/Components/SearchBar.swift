//
//  SearchBar.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText:String
    var body: some View {
        HStack {
            Button{
                print("---")
            }label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
            }.padding(.leading)
                .padding(.vertical)
            TextField("Search", text: $searchText)
                
        }.background(.white)
            .buttonBorderShape(.capsule)
            .cornerRadius(24)
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
