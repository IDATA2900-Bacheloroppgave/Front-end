//
//  NewOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 14/04/2024.
//

import SwiftUI

struct NewOrderView: View {
    
    @StateObject var newOrderViewModel = NewOrderViewModel()
    @EnvironmentObject var userStateViewModel : AuthViewModel

    @State private var user = User(email: "", firstName: "", lastName: "", store: Store(name: "", address: "", country: "", city: "", postalCode: 12, storeId: 12))
    @State private var wishedDelivery = Date()
    @State private var productAmounts: [Int: Int] = [:] // LIST OF PRODUCTID AND
    @State private var placeOrder = false
    
    @State private var itemSelected = false //SHOW FILTER VIEW
    @State private var searchterm = "" /// SEARCH TERM
    @State private var amount = 0 //AMOUNTs
    @State private var pickerSelection = 0 //PICKER FILTER
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color.white)
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
                                TextField("Search...", text: $searchterm)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 7)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .shadow(radius: 1)
                                    .foregroundColor(.black)
                                    .backgroundStyle(.white)
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
                                    
                                    .cornerRadius(5) // Adjust corner radius to match your design
                                }
                                .frame(minWidth: 0)
                                
                            }  .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            HStack{
                                Picker(selection: $pickerSelection, label: Text("Options")) {
                                    Text("All goods").tag(0)
                                    Text("Refrigerated").tag(1)
                                    Text("Freezed").tag(2)
                                    Text("Dry").tag(3)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .padding(.horizontal)
                        ScrollView{
                            ForEach(newOrderViewModel.products, id: \.productId) { product in
                                
                               // let availableQuantity = product.inventory!.availableStock
                                
                               
                                NewProductCardView(product: product, itemAvailanle: false, availableQuantity: 10, productAmounts: $productAmounts, itemSelected: $itemSelected)
                                
                               
                            }
                        }
                    }
                }
                .sheet(isPresented: $itemSelected) {
                    VStack {
                        ShoppingCartSheetView(itemSelected: $itemSelected, wishedDelivery: $wishedDelivery, placeOrder: $placeOrder, productAmounts: $productAmounts, user: $user, newOrderViewModel: newOrderViewModel)
                            .presentationDetents([.fraction(0.25)])
                            .presentationBackgroundInteraction(
                                .enabled(upThrough: .fraction(0.25))
                            )
                        
                    }
                }
                
                
                .tint(.black)
            }
        }.tint(.black)
            .onAppear() {
                Task {
                    do {
                        try await newOrderViewModel.fetchProducts()
                        // Safely unwrap the currentUser using optional binding
                        if let user = userStateViewModel.currentUser {
                            self.user = user
                        } else {
                            // Handle the case where there is no current user
                            // For example, you could redirect to a login view or show an error message
                            print("No current user available")
                        }
                    } catch {
                        print("Could not fetch products")
                    }
                }
            }

        
    }
}

#Preview {
    NewOrderView()
}
