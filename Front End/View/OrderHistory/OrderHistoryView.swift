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
                VStack(alignment: .leading) {
                    HStack {
                        Text("Orders")
                            .font(.system(size: 20))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                            .background(Color.yellow)
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
                                .font(.system(size: 30))
                                .foregroundStyle(Color.black)
                        }.padding(5)
                    }.padding()
                    
                    
                }
            }
        }
    }
}




#Preview {
    OrderHistoryView()
}

