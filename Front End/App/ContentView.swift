//
//  ContentView.swift
//  Front End
//
//  Created by Siri Sandnes on 13/04/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginViewModel : LoginViewModel
    var body: some View {
        Group{
            if loginViewModel.loggedIn == true{
                LandingPageView()
            }else{
                LogInView()
            }
        }
    }
}

#Preview {
    ContentView()
}
