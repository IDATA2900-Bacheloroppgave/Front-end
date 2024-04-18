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
                        
                        
                        NavigationLink{
                            EditProfileView()
                        }label: {
                            EditProfileCardView()
                        }
                        
                        NavigationLink{
                            ChangePasswordView()
                        }label: {
                            ChangePasswordCardView()
                        }
                        
                        HStack{
                            Text("Store:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Picker("Store:", selection: $selectedStore) {
                                ForEach(stores, id: \.self) { store in
                                    Text(store).tag(store)
                                }
                                .pickerStyle(DefaultPickerStyle())
                            }
                            .tint(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 70, maxHeight: 70)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    
                    Spacer()
                    
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
                        .background(Color.accent)
                        .cornerRadius(5)
                    }
                    .padding()
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

struct EditProfileCardView: View {
    var body: some View {
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
        .padding(.trailing)
        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct ChangePasswordCardView: View {
    var body: some View {
        HStack{
            
            VStack (alignment: .leading) {
                
                Text("Change password")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 70, maxHeight: 70)
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(5)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
    
}
