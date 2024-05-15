//
//  NewOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 14/04/2024.
//

import SwiftUI

import SwiftUI

struct NewOrderView: View {
    @StateObject var newOrderViewModel = NewOrderViewModel()
    @EnvironmentObject var userStateViewModel: AuthViewModel

    @State private var isLoading = true
    @State private var user = User(email: "", firstName: "", lastName: "", store: Store(name: "", address: "", country: "", city: "", postalCode: 12, storeId: 12))
    @State private var wishedDelivery = Date()
    @State private var productAmounts: [Int: Int] = [:]
    @State private var placeOrder = false
    @State private var showSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("New Order")
                        .font(.system(size: 22))
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                        .background(Color.accent)

                    VStack {
                        VStack {
                            HStack {
                                TextField("Search...", text: $newOrderViewModel.searchTerm)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 7)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .shadow(radius: 1)
                                    .foregroundColor(.black)
                                    .backgroundStyle(.white)
                                Button(action: {
                               
                                }) {
                                    HStack {
                                        Image(systemName: "barcode.viewfinder")
                                            .foregroundColor(.black)
                                            .font(.system(size: 25))
                                    }
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 5)
                                    .background(Color.yellow)
                                    .cornerRadius(5)
                                }
                                .frame(minWidth: 0)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            HStack {
                                Picker(selection: $newOrderViewModel.pickerSelection, label: Text("Options")) {
                                    Text("All goods").tag(0)
                                    Text("Refrigerated").tag(1)
                                    Text("Frozen").tag(2)
                                    Text("Dry").tag(3)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .padding(.horizontal)
                        if isLoading {
                            VStack {
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .bluePicker))
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            ScrollView {
                                ForEach(filteredProducts, id: \.productId) { product in
                                    NewProductCardView(product: product, itemAvailable: product.inventory.availableStock > 0, availableQuantity: product.inventory.availableStock, productAmounts: $productAmounts, showsheet: $showSheet)
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $showSheet ) {
                    VStack {
                        ShoppingCartSheetView(itemSelected: $showSheet, wishedDelivery: $wishedDelivery, placeOrder: $placeOrder, showSheet: $showSheet, productAmounts: $productAmounts, user: $user, newOrderViewModel: newOrderViewModel)
                            .presentationDetents([.fraction(0.25)])
                            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.25)))
                    }
                }
                .tint(.black)
            }
            .navigationDestination(isPresented: $placeOrder) {
                ConfirmOrderView(wishedDelivery: $wishedDelivery, productAmounts: $productAmounts, newOrderViewModel: newOrderViewModel, placeOrder: $placeOrder, showSheet: $showSheet)
                       }
        }
        .tint(.black)
        .onAppear {
            isLoading = true
            Task {
                do {
                    try await newOrderViewModel.fetchProducts()
                    if let currentUser = userStateViewModel.currentUser {
                        self.user = currentUser
                    } else {
                        print("No current user available")
                    }
                } catch {
                    print("Could not fetch products")
                }
                isLoading = false
            }
        }
    }

    var filteredProducts: [Product] {  
        switch newOrderViewModel.pickerSelection {
        case 1:
            return newOrderViewModel.products.filter { $0.productType == "REFRIGERATED_GOODS" }
        case 2:
            return newOrderViewModel.products.filter { $0.productType == "FROZEN_GOODS" }
        case 3:
            return newOrderViewModel.products.filter { $0.productType == "DRY_GOODS" }
        default:
            return newOrderViewModel.products
        }
    }
}

#Preview {
    NewOrderView()
}


#Preview {
    NewOrderView()
}


