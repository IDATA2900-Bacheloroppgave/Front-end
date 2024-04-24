//
//  LogInView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI


struct LogInView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    @StateObject var stores = StoresViewModel()
   
    
    @State private var email = ""
    @State private var password = ""
    @State private var userFeedback = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.00, green: 0.83, blue: 0.00).ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(spacing: 40) {
                        Text("TraceGo")
                            .fontWeight(.bold)
                            .font(.system(size: 45))

                        LazyVStack(spacing:20){
                            InputView(text: $email, placeholder: "Email")
                            
                            InputView(text: $password, placeholder: "Password", isSecureField: true)
                        } 
                        .background(Color.init(red: 1.00, green: 0.83, blue: 0.00))
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                        
                        VStack{
                            Text(userFeedback).foregroundStyle(Color.red)
                            Button("Log in") {
                                Task{
                                    do{
                                        try await stores.fetchStores()
                                        try await authViewModel.login(email: email, password: password)
                              
                                    }catch{
                                        print("Could not log in user")
                                        userFeedback =  authViewModel.error! ///GHER BLIR DET FEIL NÅR APPEN IKKE ER OPPE
                                    }
                                }
                            }
                            .foregroundColor(Color.black)
                            .frame(width: 150, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        }
                    }
                    Spacer()
                    NavigationLink{
                        RegisterView()
                    }label: {
                        HStack (spacing: 3) {
                            Text("Don't have an account?")
                                .foregroundColor(Color.black)
                            Text("Sign up")
                                .foregroundColor(Color.blue)
                        }
                        .padding(.bottom, 20)
                    }
                   
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        
        }.onTapGesture {
            hideKeyboard()
        }
        .onAppear {
                    // Reset user feedback
                    userFeedback = ""
                }
    }
}


#Preview {
    LogInView()
}

extension LogInView{
    func hideKeyboard() {
            let resign = #selector(UIResponder.resignFirstResponder)
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
}
