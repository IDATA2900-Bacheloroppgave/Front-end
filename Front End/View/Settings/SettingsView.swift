//
//  SettingsView.swift
//  Front End
//
//  Created by Siri Sandnes on 16/04/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedStore = "Rema Averøy" // The default selected store
    let stores = ["Rema Averøy", "Rema Ålesund", "Kiwi Ålesund"] // List of stores
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 0.96, green: 0.96, blue: 0.96)
                    .edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading, spacing: 15){
                    
                        Text("Settings")
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                            .background(.accent)
                       
                    VStack {
                        NavigationLink{
                            EditProfileView()
                        }label: {
                            HStack {
                                Text("IF")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .frame(width: 48, height: 48)
                                    .background(Color(.accent).opacity(0.5))
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal)
                                
                                VStack (alignment: .leading, spacing: 5) {
                                    Text("Ina Folland")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    
                                    
                                    Text("ina@gmail.com")
                                        .font(.body)
                                        .foregroundStyle(.gray)
                                        .tint(.gray)
                                    
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.bottom)
                        }
                        
                        Divider()
                        
                        NavigationLink{
                            ChangePasswordView()
                        }label: {
                        HStack{
                            VStack {
                                
                                Text("Change password")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .tint(.black)
                                
                            }
                            .padding()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        
                    }
                        
                        Divider()
                        
                        HStack{
                            Text("Store:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top)
                                .padding(.leading)
                            
                            Spacer()
                            
                            Picker("Store:", selection: $selectedStore) {
                                ForEach(stores, id: \.self) { store in
                                    Text(store).tag(store)
                                }
                                .pickerStyle(DefaultPickerStyle())
                            }
                            .tint(.gray)
                            .padding(.top)
                        }
                        
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 230)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                .padding(.horizontal)
                    
                    Spacer()
                }
                
            }
                    
                    
                    
                    Button(action: {
                        if let email = authViewModel.currentUser?.email, authViewModel.logout(email: email) {
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
                        .background(Color.accent)
                        .cornerRadius(5)
                    }
                    .padding()
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



