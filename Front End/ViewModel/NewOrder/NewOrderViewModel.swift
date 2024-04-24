//
//  TestViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

// FOR NOW THIS JUST FETCHES PRODUCTS

class NewOrderViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorMessage: String?
    
    
    
    func fetchProducts() async throws {
        
        DispatchQueue.main.async {
            self.products.removeAll()
        }
        
        guard let url = URL(string: "http://35.246.81.166:8080/api/products") else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else{
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
            
            do{
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async{
                    self.products.append(contentsOf: products)
                }
            }catch{
                print("MISTAKE")
                throw error
            }
            
        }
    }
}

