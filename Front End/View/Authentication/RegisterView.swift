//
//  ContentView.swift
//  Front End
//
//  Created by Siri Sandnes on 11/04/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userStateViewModel : AuthViewModel
    
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var store : Store?
    @State private var confirmPassword = ""
    
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
                                Picker(selection: $store, label: Text("Select store")) {
                                    Text("Oslo").tag(1)
                                    Text("2").tag(2)
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
                            }
                            
                            .background(Color(red: 1.00, green: 0.83, blue: 0.00))
                            .scrollContentBackground(.hidden)
                            .scrollDisabled(true)
                            Button("Create User") {
                                Task {
                                    do {
                                        try await userStateViewModel.createUser(email: email, firstName: firstname, lastName: lastname, password: password, store: store!)
                                        print("user created")
                                    } catch {
                                        print("Could not create user")
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
        .toolbar(.hidden)
    }
}

#Preview {
    RegisterView()
}
