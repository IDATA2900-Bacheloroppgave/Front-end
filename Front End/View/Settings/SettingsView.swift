//
//  SettingsView.swift
//  Front End
//
//  Created by Siri Sandnes on 16/04/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userStateViewModel : AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack{
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text("Settings")
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .background(.yellow)
                        
                        List{
                            NavigationLink{
                                EditProfileView()
                            }label: {
                                HStack{
                                    Text("IF")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .frame(width: 48, height: 48)
                                        .background(Color(.yellow).opacity(0.5))
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    
                                    VStack (alignment: .leading, spacing: 5) {
                                        Text("Ina Folland")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                        
                                        Text("ina@gmail.com")
                                            .font(.body)
                                            .foregroundStyle(.gray)
                                            .padding(.leading, 2)
                                            .tint(.gray)
                                        
                                    }}
                            }
                            .padding(.init(top: 15, leading: 0, bottom: 15, trailing: 0))
                            HStack{
                                
                                Text("Store:")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text("Rema Averøy")
                                    .font(.body)
                                    .foregroundStyle(.gray)
                                    .padding(.leading, 2)
                                    .tint(.gray)
                                
                            }
                            .padding(.init(top: 15, leading: 10, bottom: 15, trailing: 10))
                            NavigationLink{
                                ChangePasswordView()
                            }label: {
                                HStack{
                                    
                                    VStack (alignment: .leading, spacing: 5) {
                                        
                                        Text("Change password")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        
                                    }
                                }
                                .padding(.init(top: 15, leading: 10, bottom: 15, trailing: 0))
                            }}
                        
                        
                        Button(action: {
                            if userStateViewModel.logout() {
                                dismiss()
                            }
                            
                        }) {
                            HStack {
                                Text("Log out")
                                    .font(.title2)
                                Spacer()
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                
                                
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(5)
                        }
                        .padding()
                        
                    }
                }
            }
        }
    }
}

struct EditProfileView: View {
    var body: some View {
        // Your form fields here
        Text("Edit Profile View")
    }
}

struct ChangePasswordView: View {
    var body: some View {
        // Your form fields here
        Text("Change Password View")
    }
}

#Preview {
    SettingsView()
}
