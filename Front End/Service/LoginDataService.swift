//
//  LoginDataService.swift
//  Front End
//
//  Created by Siri Sandnes on 13/04/2024.
//
// NOT IN USE

import Foundation

import Foundation

class LoginDataService {
    func login(email: String, password: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "http://35.246.81.166:8080/auth/login") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginDetails = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: loginDetails, options: []) else {
            print("Failed to serialize login data to JSON")
            return
        }
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error occurred during login: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            if let jsonString = String(data: data, encoding: .utf8){
                completion(jsonString)
            }
          
        }
        
        task.resume()
    }
}

