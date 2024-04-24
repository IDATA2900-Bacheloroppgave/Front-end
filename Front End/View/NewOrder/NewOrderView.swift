//
//  NewOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 14/04/2024.
//

import SwiftUI

struct NewOrderView: View {
    @StateObject var testViewModel = NewOrderViewModel()
    @State private var searchterm = ""
    @State private var amount = 0
    @State private var pickerSelection = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96)
                    .edgesIgnoringSafeArea(.all) // Ensure the color fills the entire screen
                VStack(alignment: .leading) {
                    HStack {
                        Text("New Order")
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                            .background(.accent)
                        
                    }
                    
                    VStack{
                        VStack{
                            HStack{
                                Text("Searchbar here")
                                    .frame(maxWidth: .infinity)
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                    
                                Button(action: {
                                    // Action for the button tap
                                }) {
                                    HStack {

                                        
                                        Image(systemName: "barcode.viewfinder")
                                            .foregroundColor(.black)
                                            .font(.system(size: 25)) // Adjust icon size as needed
                                    }
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 5) // Adjust padding as needed
                                    .background(Color.yellow) // Use the color that matches your design
                                    .cornerRadius(10) // Adjust corner radius to match your design
                                }
                                .frame(minWidth: 0)
                                
                           
                            }
                            HStack{
                                Picker(selection: $pickerSelection, label: Text("Options")) {
                                    Text("All products").tag(0)
                                    Text("Option 2").tag(1)
                                    Text("Option 3").tag(2)
                                    Text("Option 4").tag(3)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .padding(.horizontal)
                        ScrollView{
                            ForEach(testViewModel.products, id: \.productId) { product in
                                
                                NewProductCardView(amount: $amount,
                                                   productIcon: "fork.knife.circle.fill",
                                                   product: product
                                )
                                
                            }
                        }
                    }
                }.tint(.black)
            }
        }.tint(.black)
            .onAppear(){
                Task{
                    do{
                        try await testViewModel.fetchProducts()
                    }catch{
                        print("Could not fetch products")
                    }
                }
                
            }
    }
}

#Preview {
    NewOrderView()
}
