//
//  ContentView.swift
//  Front End
//
//  Created by Siri Sandnes on 13/04/2024.
//

import SwiftUI
/**
 Shows different view based on if the user is logged in or not.
 */
struct ContentView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        Group{
            if authViewModel.currentUser != nil{
                TabView{
                    LandingPageView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    NewOrderView()
                        .tabItem { 
                            Image(systemName: "plus")
                            Text("Add")
                        }
                    OrderHistoryView()
                        .tabItem { 
                            Image(systemName: "doc.plaintext")
                            Text("History")
                        }
                }
            }else{
                LogInView()
            }
        }
    }
}

#Preview {
    ContentView()
}
