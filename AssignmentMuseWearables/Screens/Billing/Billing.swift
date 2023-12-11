//
//  Billing.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import SwiftUI

struct Billing: View {
    
    @ObservedObject var billingViewModel = BillingViewModel()
    @State var goToHome = false
    @State var ShowFailed = false
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                ScrollView{
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack{
                            Image("Card")
                            VStack(alignment: .leading){
                                Spacer()
                                Text("4747 4747 4747 4747")
                                    .frame(width:(geometry.size.width-30))
                                    .font(.system(size: 29))
                                
                                Spacer()
                                Text("Alexandra smith")
                                    .padding(.horizontal)
                                    .font(.system(size: 20))
                            }
                            .padding()
                            .frame(width: geometry.size.width,alignment: .leading)
                        }.foregroundColor(.white)
                        VStack(alignment: .center){
                            Button{
                                
                            }label: {
                                Image("Camera")
                            }
                        }
                        .frame(width: geometry.size.width)
                        
                        VStack(alignment: .leading){
                            ForEach(billingViewModel.billingFileds,id: \.type){ field in
                                BillingField( onTextUpdate:{ text in
                                    billingViewModel.updateValue(value: text, fieldType: field.type)
                                }, fieldModule: field)
                            }
                        }.padding()
                        VStack(alignment: .center){
                            Button {
                                billingViewModel.pay(){ status in
                                    switch status {
                                    case .failed , .canceled :
                                        ShowFailed.toggle()
                                    case .succeeded:
                                        goToHome.toggle()
                                        NavigationLink(destination: Home(sheetType: .thankyou),isActive: $goToHome, label: {EmptyView()})
                                    }
                                    
                                }
                            }label: {
                                Text("USE THIS CARD")
                                    .font(.system(size: 15,weight: .semibold))
                            }
                            
                            .frame(width: geometry.size.width*0.7 ,height: 46)
                            .background(Color("OrderNow"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .frame(width: geometry.size.width)
                        
                    }.frame(width: geometry.size.width)
                }
                .popover(isPresented: $ShowFailed){
                    Text("Failed Payment")
                }
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct Billing_Previews: PreviewProvider {
    static var previews: some View {
        Billing()
    }
}



struct BillingField: View {
    @State var text: String = ""
    var  onTextUpdate:(String)->Void
    var fieldModule:BillingFieldmodule
    var body: some View{
        Section {
            ZStack(alignment: .trailing) {
                TextField(fieldModule.title, text: $text)
                    .keyboardType(fieldModule.inputType)
                    .padding(15)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.vertical,5)
                    .onChange(of: text){ text in
                        onTextUpdate(text)
                    }
                 
                
                if fieldModule.hint {
                    Button{
                        
                    }label: {
                        Image("Hint")
                    }.padding(.trailing)
                }
            }
        }header: {
            Text(fieldModule.title)
                .font(.system(size: 14))
            
        }
    }
}

