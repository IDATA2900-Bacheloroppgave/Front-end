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
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.init(red: 1.00, green: 0.83, blue: 0.00).ignoresSafeArea()
                VStack(spacing: 40){
                    Spacer()
                    Text("TraceGo").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45))
                    VStack(spacing: 20){
                        InputView(text: $email, placeholder: "Email")
                        InputView(text: $firstname, placeholder: "Firstname")
                        InputView(text: $lastname, placeholder: "Lastname")
                        InputView(text: $password, placeholder: "Password", isSecureField: true)
                        InputView(text: $confirmPassword, placeholder: "Repeat password", isSecureField: true)
                    }
                    Button("Create User"){
                        Task{
                            do{
                                try await userStateViewModel.createUser(email: email, firstName: firstname, lastName: lastname, password: password)
                                userStateViewModel.login(email: email, password: password)
                                print("user created")
                            }catch{
                                print("Could not create user")
                            }
                        }
                    }
                    .foregroundStyle(Color(.black))
                    .frame(width: 150, height: 50)
                    .background(Color.white)
                    .overlay(
                         RoundedRectangle(cornerRadius: 25)  // Set the corner radius here
                             .stroke(Color.black, lineWidth: 2)  // This adds the border
                     )
                     .clipShape(RoundedRectangle(cornerRadius: 25))
                    Spacer()
                    Button{
                        dismiss()
                    }label: {
                        HStack (spacing: 3) {
                            Text("Allready have an account?")
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
