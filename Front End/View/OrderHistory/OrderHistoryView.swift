//
//  OrderHistoryView.swift
//  Front End
//
//  Created by Siri Sandnes on 14/04/2024.
//

import SwiftUI


struct OrderHistoryView: View {
    @State private var selection = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96)
                    .edgesIgnoringSafeArea(.all) // Ensure the color fills the entire screen
                VStack(alignment: .leading) {
                    HStack {
                        Text("Orders")
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                            .background(.accent)
                            
                    }
                    
                    HStack {
                        Picker("Options", selection: $selection) {
                            Text("Active").tag(0).foregroundStyle(Color.white)
                            Text("Past").tag(1)
                        }
                        .colorMultiply(.bluePicker)
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button(action: {}) {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 25))
                                .foregroundStyle(Color.black)
                        }
                    }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    Spacer()
                }
            }
        }
    }
}




#Preview {
    OrderHistoryView()
}

