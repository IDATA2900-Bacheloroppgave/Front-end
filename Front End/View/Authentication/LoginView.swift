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
    
    
    @State private var email = "test@test.no"
    @State private var password = "test12345"
    @State private var emailBorderColor = Color.black
    @State private var passwordBorderColor = Color.black
    @State private var userFeedback = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.solwrLoginBackground).ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack {
                        Text("TraceGo")
                            .foregroundStyle(.solwrMainTitle)
                            .fontWeight(.bold)
                            .font(.system(size: 45))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        
                        LazyVStack(spacing: 20) {
                            InputView(text: $email, placeholder: "Email", borderColor: emailBorderColor)
                                .onChange(of: email){
                                    let isValid = authViewModel.validateEmail(email: email)
                                    emailBorderColor = isValid ? .black : .red
                                }
                            
                            InputView(text: $password, placeholder: "Password", isSecureField: true, borderColor: passwordBorderColor)
                                .onChange(of: password) {
                                    let isValid = authViewModel.validatePassword(password: password)
                                    passwordBorderColor = isValid ? .black : .red
                                }
                            
                            Text(userFeedback)
                                .foregroundColor(.red)
                                .frame(height: 20) // Fixed frame height
                                .opacity(userFeedback.isEmpty ? 0 : 1)
                            
                            Button("Log in") {
                                performLogin()
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
                        .background(Color.init(.solwrLoginBackground))
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                        
                       
                    }
                    Spacer()
                    NavigationLink{
                        RegisterView()
                    }label: {
                        HStack (spacing: 3) {
                            Text("Don't have an account?")
                                .foregroundColor(.solwrMainTitle)
                            Text("Sign up")
                                .foregroundColor(.solwrYellowBlueBtn)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            // Reset user feedback
            userFeedback = ""
        }
    }
    
    
    func performLogin() {
        if !authViewModel.validateEmail(email: email) && !authViewModel.validatePassword(password: password) {
            userFeedback = "Invalid email and password"
            emailBorderColor = .red
            passwordBorderColor = .red
        }else if !authViewModel.validateEmail(email: email) {
            userFeedback = "Invalid email"
            emailBorderColor = .red
        }else if !authViewModel.validatePassword(password: password) {
            userFeedback = "Invalid password"
            passwordBorderColor = .red
        } else {
            userFeedback = ""
            passwordBorderColor = .black
            passwordBorderColor = .black
            Task {
                do {
                    try await stores.fetchStores()
                    try await authViewModel.login(email: email, password: password)
                } catch {
                    userFeedback = authViewModel.error
                }
            }
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


