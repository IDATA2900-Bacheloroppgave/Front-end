//
//  AuthViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

import Foundation

class LoginViewModel: ObservableObject {

    // This function will be called to perform the login operation.
    func login(email: String, password: String) {
        guard let url = URL(string: "http://35.246.81.166:8080/auth/login") else {
            print("Invalid URL")
            return
        }
        
        // Create the URL request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set the HTTP body with email and password
        let loginDetails = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: loginDetails, options: []) else {
            print("Failed to serialize login data to JSON")
            return
        }
        request.httpBody = httpBody
        
        // Create the URLSession data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle the error scenario
                print("Error occurred during login: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // Handle the response error
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                // If you expect a JSON response, handle it here
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response: \(jsonResponse)")
                } catch {
                    print("Failed to decode JSON response: \(error)")
                }
            }
        }
        
        // Start the task
        task.resume()
    }
}

