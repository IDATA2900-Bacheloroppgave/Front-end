//
//  FilterOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 23/04/2024.
//

import SwiftUI

struct FilterOrderView: View {
    @Binding var isVisible: Bool
    @Binding  var quickFilter: Int
    @Binding var toDate: Date
    @Binding var fromDate: Date

        var body: some View {
            VStack {
                HStack{
                    HStack{
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 20))
                        Text("Filter")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                    Button("X") {
                        isVisible = false
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.black).font(.system(size: 20))
                   
                }  
                .padding(.horizontal)
                VStack{
                    VStack{
                        Text("Quick filters")
                            .fontWeight(.medium)
                            .padding(.horizontal)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                         
                        HStack{
                            Picker("Options", selection: $quickFilter) {
                                Text("Past week").tag(0).foregroundStyle(Color.white)
                                Text("Past month").tag(1)
                                Text("Pas six months").tag(2)
                            }
                            .padding(.horizontal)
                            .colorMultiply(.accent)
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                       
                    }
                
                    VStack{
                        Text("Date")
                            .padding(.horizontal)
                            .fontWeight(.medium)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                      
                     
                            DatePicker(selection: $toDate,
                                   in: ...Date(),
                                   displayedComponents: .date,
                                   label: {
                                       Text("To:")
                                   }
                               ) .padding(.horizontal)
                            DatePicker(selection: $fromDate,
                                   in: ...Date(),
                                   displayedComponents: .date,
                                   label: {
                                       Text("From:")
                                   }
                               ) .padding(.horizontal)
                           
        
                    }

                    .padding(.vertical)
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical)
           
                Spacer()
            }
            .padding(.vertical)
            .background(Color.white)
            .cornerRadius(10)
        }
}

#Preview {
    FilterOrderView(isVisible: .constant(true), quickFilter: .constant(0), toDate: .constant(Date.now), fromDate: .constant(Date.now))
}
