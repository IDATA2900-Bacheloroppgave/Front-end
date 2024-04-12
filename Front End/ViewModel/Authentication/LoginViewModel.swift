//
//  AuthViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

import Foundation

class LoginViewModel: ObservableObject {
    @Published var loggedIn = false
    @Published var token: String = ""
    
    private let service = LoginDataService()

    // This function will be called to perform the login operation.
    func login(email: String, password: String) {
        service.login(email: "siris@gmail.com", password: "Testpassword11hehe"){ token in
            DispatchQueue.main.async{
                self.token = token
                self.loggedIn = true
            }
        }
    }
}

