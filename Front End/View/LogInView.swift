//
//  LogInView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI


struct LogInView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var loginSuccessful = false  // Corrected the typo in variable name
    
    var body: some View {
        Text("Rediger fil og legg inn")
    }
}


#Preview {
    LogInView()
}
