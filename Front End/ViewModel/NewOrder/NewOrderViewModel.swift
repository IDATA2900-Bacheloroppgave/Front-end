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
    
    func placeOrder(wishedDate: Date, orderList: [Int:Int], user: User)  async throws {
        print("PLACED ORDER")
        
        let jsonBody = try createJSONBody(wishedDate: wishedDate, productAmounts: orderList)
        
        let urlString = "http://35.246.81.166:8080/api/orders/createorder"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let headers = [
            "content-type" : "application/json",
            "authorization" : "Bearer \(user.token!)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        
        guard let httpBody = try?
                jsonBody else {
            print("Failed to serialize login data to JSON")
            throw NSError(domain: "Serialization Error", code: 0, userInfo: nil)
        }
        
        request.httpBody = httpBody
        
        do{
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
                
            }
        }
    }
    
    
    func createJSONBody(wishedDate: Date, productAmounts: [Int: Int]) throws -> Data {
        // Convert Date to ISO8601 string representation
        let dateFormatter = ISO8601DateFormatter()
        let wishedDateString = dateFormatter.string(from: wishedDate)
        
        // Map productAmounts to JSON structure
        let quantities = productAmounts.map { (productId, quantity) -> [String: Any] in
            return [
                "productQuantity": quantity,
                "product": [
                    "productId": productId
                ]
            ]
        }
        
        print(quantities)
        
        // Construct JSON body
        let jsonBody: [String: Any] = [
            "wishedDeliveryDate": wishedDateString, // Use the string representation of the date
            "quantities": quantities
        ]
        
        // Step 2: Serialize the JSON data
        guard JSONSerialization.isValidJSONObject(jsonBody) else {
            throw NSError(domain: "Invalid JSON", code: 0, userInfo: nil)
        }
        
        return try JSONSerialization.data(withJSONObject: jsonBody)
    }
    
    
    
}
