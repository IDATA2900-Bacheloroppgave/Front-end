//
//  Front_EndApp.swift
//  Front End
//
//  Created by Siri Sandnes on 11/04/2024.
//

import SwiftUI

@main
struct Front_EndApp: App {
    @StateObject var viewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
