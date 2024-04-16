//
//  ContentView.swift
//  Front End
//
//  Created by Siri Sandnes on 11/04/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    @StateObject var storesViewModel = StoresViewModel()
    
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var selectedStore = Store(name: "", address: "", country: "", city: "", postalCode: 0, storeId: -1)
    @State private var confirmPassword = ""
    @State private var userFeedback = ""
    @State private var color = Color.blue
    
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        NavigationStack {
                    ZStack {
                        Color(red: 1.00, green: 0.83, blue: 0.00).ignoresSafeArea()
                        VStack(spacing: 40) {
                            Spacer()
                            Spacer()
                            Text("TraceGo").fontWeight(.bold).font(.system(size: 45))
                        
                            LazyVStack(spacing: 20) {
                                InputView(text: $email, placeholder: "Email")
                                InputView(text: $firstname, placeholder: "Firstname")
                                InputView(text: $lastname, placeholder: "Lastname")
                                InputView(text: $password, placeholder: "Password", isSecureField: true)
                                Picker("Select store", selection: $selectedStore) {
                                    if storesViewModel.stores.isEmpty {
                                        Text("No stores to select")
                                    } else {
                                        ForEach(storesViewModel.stores, id: \.storeId) { store in
                                            Text(store.name).tag(store)
                                        }
                                    }
                                }
                                .frame(width: 300, height: 50)
                                .background(Color.white)
                                .foregroundStyle(Color.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .textInputAutocapitalization(.never)
                                .listRowBackground(Color(red: 1.00, green: 0.83, blue: 0.00))
                                .listRowSeparator(.hidden)
                                .accentColor(.black)
                                
                            }
                            
                            .background(Color(red: 1.00, green: 0.83, blue: 0.00))
                            .scrollContentBackground(.hidden)
                            .scrollDisabled(true)
                           
                            
                            Text(userFeedback).foregroundStyle(Color.red)
                            Button("Create User") {
                                print("inside button")
                                Task {
                                    do {
                                        print(selectedStore)
                                        if !storesViewModel.stores.isEmpty{
                                            try await authViewModel.createUser(email: email, firstName: firstname, lastName: lastname, password: password, store: selectedStore)
                                        }else{
                                            userFeedback = "A store must be selected"
                                        }
                                       
                                    } catch {
                                        print("Could not create user")
                                        userFeedback =  authViewModel.error!
                                        
                                    }
                                }
                            }
                            .foregroundStyle(Color(.black))
                            .frame(width: 150, height: 50)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                HStack(spacing: 3) {
                                    Text("Already have an account?")
                                        .foregroundColor(Color.black)
                                    Text("Sign in")
                                        .foregroundColor(Color.blue)
                                }
                                .padding(.bottom, 20)
                            }
                          
                        }
                    }
                }
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar(.hidden)
        .onAppear(){
        
            userFeedback = ""
            
            Task {
                do{
                    try await storesViewModel.fetchStores()
                    if let firstStore = storesViewModel.stores.first {
                            selectedStore = firstStore
                        }
                
                }catch{
                    print("could not fetch stores..")
                }
         
            }
        }
        
    }
}

#Preview {
    RegisterView()
}

extension RegisterView{
    func hideKeyboard() {
            let resign = #selector(UIResponder.resignFirstResponder)
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
}
