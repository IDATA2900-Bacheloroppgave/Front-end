//
//  ValidataionViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 16/04/2024.
//

import Foundation
import SwiftUI


class ValidationViewModel: ObservableObject {
    @Published var emailValidationColor: Color = .red
    @Published var passwordValidationColor: Color = .red

    func validateEmail(_ email: String) {
        // Example validation logic for email
        if email.count > 8 {
            emailValidationColor = .green
        } else {
            emailValidationColor = .red
        }
    }

    func validatePassword(_ password: String) {
        // Example validation logic for password
        if password.count >= 8 {
            passwordValidationColor = .green
        } else {
            passwordValidationColor = .red
        }
    }
}
