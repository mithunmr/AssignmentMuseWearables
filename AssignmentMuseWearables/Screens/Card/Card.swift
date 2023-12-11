//
//  Billing.swift
//  AssignmentMuseWearables
//
//  Created by MRM on 07/12/23.
//

import SwiftUI

struct Card: View {
    
    @ObservedObject var cardViewModel = CardViewModel()
    
  
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
                            ForEach(cardViewModel.cardFileds,id: \.type){ field in
                                CardField( onTextUpdate:{ text in
                                    cardViewModel.updateValue(value: text, fieldType: field.type)
                                }, fieldModule: field)
                            }
                        }.padding()
                        VStack(alignment: .center){
                            NavigationLink(destination: Address(),isActive: $cardViewModel.goToAddress, label: {EmptyView()})
                            Button {
                                cardViewModel.addCard()
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
               
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct Billing_Previews: PreviewProvider {
    static var previews: some View {
        Card()
    }
}



struct CardField: View {
    @State var text: String = ""
    var  onTextUpdate:(String)->Void
    var fieldModule:CardFieldmodule
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

