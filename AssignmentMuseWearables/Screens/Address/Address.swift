//
//  Address.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import SwiftUI


struct Address: View {
    @ObservedObject var addressViewModel = AddressViewModel()
  
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing:30){
                        //Payment Method
                        Section {
                            HStack(){
                                Image("Credit_card")
                                    .padding(.trailing)
                                Text("**** **** **** 4747")
                                    .font(.system(size: 17))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }header: {
                            SectionHeader( headerText: "Payment Method", action: {print("----")})
                        }
                        
                        //Delivery Address
                        Section{
                            HStack(alignment: .top){
                                Image("Home")
                                    .padding(.trailing)
                                Text("""
                                     Alexandra Smith
                                     Cesu 31 k-2 5.st,SIA Chili
                                     Riga
                                     LV–1012
                                     Latvia
                                    
                                    """)
                                .font(.system(size: 15,weight: .light))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .padding(.top,5)
                                Spacer()
                            }
                        }header: {
                            SectionHeader(headerText: "Delivery Address", action: {print("----")})
                        }
                        
                        // Delivery Options
                        Section {
                            VStack{
                                ForEach(addressViewModel.deliveryOptions,id:\.deliveryType){ type in
                                    HStack(){
                                        Image(type.image)
                                            .renderingMode(.template)
                                            .foregroundColor(type.isSlected ? Color("#7203FF") : .gray )
                                            .padding(.trailing)
                                    
                                        
                                        Text(type.title)
                                            .font(.system(size: 17))
                                            .foregroundColor(type.isSlected ? Color("#7203FF") : .gray )
                                        Spacer()
                                        
                                        if type.isSlected{
                                            Image("Check")
                                        }
                                    }
                                    .frame(height: 40)
                                    .onTapGesture {
                               
                                        addressViewModel.selectDevliveryOption(deliveryType: type.deliveryType)
                                    }
                                }
                            }
                            .listStyle(.plain)
                            
                        } header: {
                            SectionHeader(headerText: "Delivery Options",buttonType: .radio, action: {print("----")})
                        }
                        
                        SectionHeader(headerText: "Non-Contact Delivery",buttonType: .radio, action: {print("----")})
                        
                        VStack(alignment: .center){
                            NavigationLink(destination: Home(sheetType: .thankyou),isActive:$addressViewModel.goToHome , label: {EmptyView()})
                            Button {
                                addressViewModel.makePayment()
                            }label: {
                                Text("MAKE PAYMENT")
                                    .font(.system(size: 15,weight: .semibold))
                            }
                            
                            .frame(width: geometry.size.width*0.7 ,height: 46)
                            .background(Color("OrderNow"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                     
                      
                        
                        
                    }
                    .padding()
                    
                }
                .popover(isPresented: $addressViewModel.ShowFailed){
                    Text("Failed Payment")
                }
            }.navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct SectionHeader:View {
    @State var isOn:Bool =  false
    var headerText:String
    var buttonText:String = "CHANGE"
    var buttonType:ButtonType = .normal
    var action:()->Void
    
    var body: some View {
        HStack{
            
            switch buttonType {
            case .normal:
                Text(headerText)
                    .font(.system(size: 22,weight: .semibold))
                    .lineLimit(1)
                
                Spacer(minLength: 0)
                Button{
                    action()
                }label: {
                    Text(buttonText)
                        .font(.system(size: 15,weight: .semibold))
                        .foregroundColor(Color("#7203FF"))
                }
            case .radio:
                Toggle(isOn: $isOn,
                       label: {
                    Text(headerText)
                        .font(.system(size: 22,weight: .semibold))
                    .lineLimit(1)})
                
                .tint(Color("#7203FF"))
               
            }
            
        }
    }
}

enum ButtonType {
    case normal
    case radio
}

struct Address_Previews: PreviewProvider {
    static var previews: some View {
        Address()
    }
}
