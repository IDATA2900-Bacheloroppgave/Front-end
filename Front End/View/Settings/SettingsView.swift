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
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96)
            Button(action: {
                
                if userStateViewModel.logout(){
                    dismiss()
                }
            }, label: {
                Text("Log out")
                    .foregroundStyle(Color.black)
            })
        }
    }
}

#Preview {
    SettingsView()
}
