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
    @State private var selectedStore = "Rema Averøy"
    let stores = ["Rema Averøy", "Rema Ålesund", "Kiwi Ålesund"]
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(.solwrBackground)
                    .edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading, spacing: 15){
                    HStack{
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                            .foregroundStyle(.solwrMainTitle)
                            .font(.system(size: 22))
                           
                    }
                    .frame(maxWidth: .infinity)
                    
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    
                    VStack {
                        NavigationLink{
                            EditProfileView()
                        }label: {
                            HStack {
                                Text("IF")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .frame(width: 48, height: 48)
                                    .background(.solwrLightDarkYellow)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal)
                                
                                VStack (alignment: .leading, spacing: 5) {
                                    Text("Ina Folland")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.solwrMainTitle)
                                    
                                    
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
                                        .tint(.solwrMainTitle)
                                    
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
                            .tint(.solwrMainTitle)
                            .padding(.top)
                        }
                        
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 230)
                    .background(.solwrCardBackground)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                Spacer()
                
                Button(action: {
                    if let email = authViewModel.currentUser?.email, authViewModel.logout(email: email) {
                                        dismiss()
                                    }
                }) {
                    HStack {
                        Text("Log out")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.black)
                            .font(.system(size: 35))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(.solwrYellow)
                    .cornerRadius(10)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                
                
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



