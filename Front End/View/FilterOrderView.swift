//
//  FilterOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 23/04/2024.
//

import SwiftUI

struct FilterOrderView: View {
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
                                Text("Past week").tag(1).foregroundStyle(Color.white)
                                Text("Past month").tag(2)
                                Text("Past six months").tag(3)
                            }
                            .onChange(of: quickFilter) { newValue, _ in
                                // Handle changes in quickFilter selection
                                print(quickFilter)
                                    if quickFilter == 1 {
                                        // Perform actions for Past week selection
                                        // Example: Update toDate and fromDate based on past week
                                        let pastWeekDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                                        toDate = Date() // Set toDate to current date
                                        fromDate = pastWeekDate // Set fromDate to past week date
                                    } else if quickFilter == 2 {
                                        // Perform actions for Past month selection
                                        // Example: Update toDate and fromDate based on past month
                                        let pastMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
                                        toDate = Date() // Set toDate to current date
                                        fromDate = pastMonthDate // Set fromDate to past month date
                                    } else if quickFilter == 3 {
                                        // Perform actions for Past six months selection
                                        // Example: Update toDate and fromDate based on past six months
                                        let pastSixMonthsDate = Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()
                                        toDate = Date() // Set toDate to current date
                                        fromDate = pastSixMonthsDate // Set fromDate to past six months date
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
                    
                    VStack{
                        Button(action: {
                            toDate = Date()
                            fromDate = Date()
                            nowDate = Date()
                            quickFilter = 0
                            isVisible = false
                        }) {
                            HStack {
                                Text("Remove filters")
                                    .font(.system(size: 16, weight: .medium)) // Adjust font size and weight as needed
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10) // Adjust padding as needed
                            .background(.warning) // Use the color that matches your design
                            .cornerRadius(10) // Adjust corner radius to match your design
                        }
                        .padding(.horizontal)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        Button(action: {
                            isVisible = false
                        }) {
                            HStack {
                                Text("See results")
                                    .font(.system(size: 16, weight: .medium)) // Adjust font size and weight as needed
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10) // Adjust padding as needed
                            .background(.greenProgressbar) // Use the color that matches your design
                            .cornerRadius(10) // Adjust corner radius to match your design
                        }
                        .padding(.horizontal)
                        .frame(minWidth: 0, maxWidth: .infinity)
                      
                    }.padding(.vertical)
                    
                }
                .padding(.horizontal)
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
    FilterOrderView(isVisible: .constant(true), quickFilter: .constant(0), toDate: .constant(Date.now), fromDate: .constant(Date.now), nowDate: .constant(Date.now))
}
