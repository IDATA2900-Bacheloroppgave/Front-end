//
//  RegisterViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

class RegisterViewModel: ObservableObject{
    @Published var userCreated = false
    
    func createUser(email: String, firstName: String, lastName: String, password: String) async throws {
        let urlString = "http://35.246.81.166:8080/auth/register"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let newUserDetails: [String: Any] = [
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "password": password
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: newUserDetails, options: []) else {
            print("Failed to serialize user data to JSON")
            throw NSError(domain: "Serialization Error", code: 0, userInfo: nil)
        }
        request.httpBody = httpBody

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }

            DispatchQueue.main.async {
                self.userCreated = true
            }
        } catch {
            print("Error occurred while creating user: \(error.localizedDescription)")
            throw error
        }
    }

}
