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
    
    // Border colors for validation
    @State private var emailBorderColor = Color.black
    @State private var passwordBorderColor = Color.black
    @State private var firstnameBorderColor = Color.black
    @State private var lastnameBorderColor = Color.black
    
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.00, green: 0.83, blue: 0.00).ignoresSafeArea()
                VStack() {
                    Spacer()
                    Spacer()
                    Text("TraceGo").fontWeight(.bold).font(.system(size: 45))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                    
                    LazyVStack(spacing: 20) {
                        InputView(text: $firstname, placeholder: "Firstname", borderColor: firstnameBorderColor)
                            .onChange(of: firstname) {
                                firstnameBorderColor = authViewModel.validateName(name: firstname) ? .black : .red
                            }
                        InputView(text: $lastname, placeholder: "Lastname", borderColor: lastnameBorderColor)
                            .onChange(of: lastname) {
                                lastnameBorderColor = authViewModel.validateName(name: lastname) ? .black : .red
                            }
                        InputView(text: $email, placeholder: "Email", borderColor: emailBorderColor)
                            .onChange(of: email) {
                                emailBorderColor = authViewModel.validateEmail(email: email) ? .black : .red
                            }
                        InputView(text: $password, placeholder: "Password", isSecureField: true, borderColor: passwordBorderColor)
                            .onChange(of: password) {
                                passwordBorderColor = authViewModel.validatePassword(password: password) ? .black : .red
                            }
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
                        
                        Text(userFeedback)
                            .foregroundColor(.red)
                            .frame(height: 30) // Fixed frame height
                            .opacity(userFeedback.isEmpty ? 0 : 1)
                        
                        
                        Button("Create User") {
                            createUser()
                        }
                        .foregroundStyle(Color(.black))
                        .frame(width: 150, height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        
                        
                        
                    }
                    
                    .background(Color(red: 1.00, green: 0.83, blue: 0.00))
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    
                    Spacer()
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
    
    func validateName(name: String) -> Bool {
        return !name.isEmpty && name.count >= 2
    }
    
    func createUser() {
        let isFirstNameValid = validateName(name: firstname)
        let isLastNameValid = validateName(name: lastname)
        let isEmailValid = authViewModel.validateEmail(email: email)
        let isPasswordValid = authViewModel.validatePassword(password: password)
        let isStoreSelected = !storesViewModel.stores.isEmpty && selectedStore.storeId != -1
        
        // Check if all fields are invalid
        if !isFirstNameValid && !isLastNameValid && !isEmailValid && !isPasswordValid {
            userFeedback = "Please ensure all fields are filled correctly"
            firstnameBorderColor = .red
            lastnameBorderColor = .red
            emailBorderColor = .red
            passwordBorderColor = .red
            return  // Early exit if all validations fail
        }
        
        // Individual checks to provide specific feedback if not all fields are invalid
        else if !isFirstNameValid {
            userFeedback = "First name must be at least 2 characters"
            firstnameBorderColor = .red
        }
        else if !isLastNameValid {
            userFeedback = "Last name must be at least 2 characters"
            lastnameBorderColor = .red
        }
        else if !isEmailValid {
            userFeedback = "Invalid email"
            emailBorderColor = .red
        }
        else if !isPasswordValid {
            userFeedback = "Password not meeting requirements"
            passwordBorderColor = .red
        }
        else if !isStoreSelected {
            userFeedback = "A store must be selected"
        }else  {
            Task {
                do {
                    try await authViewModel.createUser(email: email, firstName: firstname, lastName: lastname, password: password, store: selectedStore)
                    userFeedback = "User successfully created"
                    firstnameBorderColor = .black
                    lastnameBorderColor = .black
                    emailBorderColor = .black
                    passwordBorderColor = .black
                } catch {
                    print("Could not create user")
                    userFeedback = authViewModel.error
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
