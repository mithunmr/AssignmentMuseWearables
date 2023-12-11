//
//  Main.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import SwiftUI

struct Main: View {
    var tabItems:[TabBarItems] = TabBarItems.allCases
    @State var selectedTab:TabBarItems = .categories
    var body: some View {
        NavigationView {
            
            GeometryReader { geometry in
                
                ZStack (alignment: .bottom) {
                    
                    switch selectedTab {
                    case .categories:
                        Categories()
                    case .cart:
                        Cart(bottomSpacer: true)
                    case .profile:
                        Address()
                    }
                    
                    //Bottom Tab Bar
                    BottomTabBar(selectedTab: $selectedTab, tabItems: tabItems)
                }
                .frame(height: geometry.size.height,alignment: .top)
                .padding(.top,geometry.safeAreaInsets.top)
                .background(Color("#EEEEEE"))
                .ignoresSafeArea()
                .navigationTitle(selectedTab.rawValue)
                //toolbar
                
            }
        }
    }
}



struct BottomTabBar:View {
  
    @Binding var selectedTab:TabBarItems
    @State var cartItemCount:Int = 0
    var tabItems:[TabBarItems]
    
    var body: some View {
        GeometryReader {geometry in
            ZStack{
                customShape()
                    .foregroundColor(Color("#EEEEEE"))
                    .shadow(radius: 1)
                HStack(){
                    ForEach(tabItems,id:\.self){ tabItem in
                        Spacer()
                        Button{
                            selectedTab = tabItem
                        }label: {
                            ZStack {
                                if tabItem == .cart{
                                    ZStack{
                                        Circle()
                                            .foregroundColor(Color("#CBF265"))
                                        Circle()
                                            .stroke(lineWidth: 2)
                                        Text(String(cartItemCount))
                                            .font(.system(size: 10))
                                            .bold()
                                            .onAppear{
                                               cartItemCount = AppModule.shared.cartManager.cartItems.count
                                            }
                                        
                                            
                                    }.frame(width: 18,height: 18)
                                        .offset(x:10,y:-12)
                                        
                                    
                                }
                                Image(tabItem.rawValue)
                            }
                            .frame(width: 60, height: 60)
                            .foregroundColor(.black)
                          
                        }
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width,height: geometry.size.height)
            }
        }.frame(height: 80)
    }
}

enum TabBarItems:String,CaseIterable {
    case categories = "Categories"
    case cart = "Cart"
    case profile = "Profile"
}

struct customShape:Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addQuadCurve(to:  CGPoint(x: rect.maxX*0.2, y: rect.minY),
                              control: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX*0.8, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x:rect.maxX,y:rect.maxY),
                              control:CGPoint(x: rect.maxX, y: rect.minY) )
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
