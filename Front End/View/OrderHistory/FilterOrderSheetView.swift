//
//  FilterOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 23/04/2024.
//

import SwiftUI

struct FilterOrderSheetView: View {
    @Binding var isVisible: Bool
    @Binding var quickFilter: Int
    @Binding var toDate: Date
    @Binding var fromDate: Date
    @Binding var nowDate : Date
  

        var body: some View {
            VStack {
                HStack{
                    HStack{
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 20))
                        Text("Filter")
                            .font(.system(size: 20))
                            .foregroundColor(.solwrMainTitle)
                    }
                    
                    Button {
                        isVisible = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundStyle(.solwrMainTitle)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.black).font(.system(size: 20))
                
                   
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                .padding(.horizontal)
                
              
                VStack{
                    VStack{
                        Text("Quick filters")
                            .fontWeight(.medium)
                            .padding(.horizontal)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                         
                        HStack{
                            Picker("Options", selection: $quickFilter) {
                                Text("Past week").tag(1).foregroundStyle(Color.white)
                                Text("Past month").tag(2)
                                Text("Past six months").tag(3)
                            }
                            .onChange(of: quickFilter) { newValue, _ in
                      
                                print(quickFilter)
                                    if quickFilter == 1 {
                                     
                                        let pastWeekDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                                        toDate = Date()
                                        fromDate = pastWeekDate
                                    } else if quickFilter == 2 {
                                      
                                        let pastMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
                                        toDate = Date()
                                        fromDate = pastMonthDate
                                    } else if quickFilter == 3 {
                                        
                                        let pastSixMonthsDate = Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()
                                        toDate = Date() 
                                        fromDate = pastSixMonthsDate
                                    }
                                }
                            
                            .padding(.horizontal)
                            //.colorMultiply(.accent)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                       
                    }
                
                    VStack{
                        Text("Date")
                            .padding(.horizontal)
                            .fontWeight(.medium)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                      
                        DatePicker(selection: $fromDate,
                               in: ...Date(),
                               displayedComponents: .date,
                               label: {
                                   Text("From:")
                               }
                           ) .padding(.horizontal)
                            
                        DatePicker(selection: $toDate,
                                   in: ...Date(),
                                   displayedComponents: .date,
                                   label: {
                                       Text("To:")
                                   }
                               ) 
                        .padding(.horizontal)

                    }
                    .padding(.vertical)
                    
                    HStack{
                        Button(action: {
                            toDate = Date()
                            fromDate = Date()
                            nowDate = Date()
                            quickFilter = 0
                            isVisible = false
                        }) {
                            HStack {
                                Text("Remove filters")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.solwrMainTitle)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color(.iphonegrey))
                            .cornerRadius(10)
                        }
                        
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        Button(action: {
                            isVisible = false
                        }) {
                            HStack {
                                Text("See results")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(.solwrYellow)
                            .cornerRadius(10)
                        }
                        
                        .frame(minWidth: 0, maxWidth: .infinity)
                      
                    }.padding(.vertical)
                        .padding(.horizontal)
                    
                }
                .padding(.horizontal)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical)
           
                Spacer()
            }
            .padding(.vertical)
          
            .cornerRadius(10)
        }
}

#Preview {
    FilterOrderSheetView(isVisible: .constant(true), quickFilter: .constant(0), toDate: .constant(Date.now), fromDate: .constant(Date.now), nowDate: .constant(Date.now))
}
