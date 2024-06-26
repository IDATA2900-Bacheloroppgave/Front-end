//
//  ResetPasswordView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var username = ""
 
    @State private var loginSuccessful = false  
    @State var color = Color.red
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.solwrMainTitleBackground).ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(spacing: 40) {
                        Text("TraceGo")
                            .foregroundStyle(.solwrMainTitle)
                            .fontWeight(.bold)
                            .font(.system(size: 45))

                        VStack(spacing: 20) {
                            InputView(text: $username, placeholder: "Username")
                            Text("Please enter email above \n to reset your password").multilineTextAlignment(.center)
                        }
                       
                        Button("Reset") {
                    
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
                    Spacer()
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(Color.black)
                        Button("Sign up") {
                         
                        }
                        .foregroundColor(Color.blue)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
    }
}


#Preview {
    ResetPasswordView()
}
