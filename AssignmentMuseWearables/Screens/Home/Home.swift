//
//  Home.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 06/12/23.
//

import SwiftUI

struct Home: View {
    @State var showSheet = false
    @State var goToCategories = false
    @ObservedObject var homeViewModel:HomeViewModel
    init(sheetType:HomePopSheet) {
        homeViewModel = HomeViewModel(sheetType: sheetType)
    }
    var body: some View {
        NavigationStack {
            NavigationLink(destination: Main(),isActive: $goToCategories) {EmptyView()}
            ZStack {
                Image("HomeBG")
            }
            .sheet(isPresented: $showSheet){
                if let homeData = homeViewModel.homeData {
                    BottomSheet(dismiss: $showSheet, homeData: homeData, orderNow: orderNow)
                        .presentationDetents([.medium])
                        .background(.clear)
                }
             
            }
            .background(LinearGradient(colors: [Color("#BD8AFFCD"),Color("#B588EE80"),.white], startPoint: .top, endPoint: .center))
            .onAppear{
                showSheet.toggle()
            }
        }
    }
    
    func orderNow(){
        showSheet.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            goToCategories.toggle()
        }
    }
}

struct BottomSheet:View {
    @Binding var dismiss:Bool
    var homeData:HomeModel
    var orderNow:()->Void
    var body: some View {
        GeometryReader{ geometry in
            VStack(){
                ZStack{
                    Circle()
                        .stroke(lineWidth: 1)
                        .foregroundColor(.gray)
                    Image("Box")
                }.frame(width: 100,height: 100)
                    .padding(.top,30)
                Text(homeData.title)
                    .font(.system(size: 34,weight: .bold))
                    .padding(11)
                Text(homeData.discription)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 15,weight: .regular))
                    .foregroundColor(Color("#9586A8"))
                    .padding(.horizontal)
                
                Button{
                    orderNow()
                }label: {
                    Text(homeData.greenButtonTitle)
                        .foregroundColor(.white)
                }.frame(width: geometry.size.width*0.8, height:  52)
                    .background(Color("OrderNow"))
                    .cornerRadius(15)
                    .padding(.vertical)
                Button{
                    dismiss.toggle()
                }label: {
                    Text(homeData.witeButtonTitle)
                        .foregroundColor(.black)
                }.frame(width: geometry.size.width*0.8, height:  46)
                    .background(.white)
                    .cornerRadius(15)
                
            }.frame(width: geometry.size.width,height: geometry.size.height,alignment: .top)
                .background(Color("#EEEEEE"))
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(sheetType: .wellcome)
    }
}
