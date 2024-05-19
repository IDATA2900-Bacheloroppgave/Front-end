//
//  Front_EndApp.swift
//  Front End
//
//  Created by Siri Sandnes on 11/04/2024.
//

import SwiftUI

@main
struct Front_EndApp: App {
    //Listens to changes in LoginViewModel
    @StateObject var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authViewModel) 
        }
    }
}
