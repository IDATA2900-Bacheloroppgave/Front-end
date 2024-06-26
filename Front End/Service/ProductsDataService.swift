//
//  TestDataService.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

class ProductsDataService{
    func fetchProducts(completion: @escaping([Product]) -> Void) {
        guard let url = URL(string: "http://35.246.81.166:8080/api/products") else {
            print("Invalid URL")
   //         self.errorMessage = "Invalid url"
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
               
 //             self?.errorMessage = error.localizedDescription
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
               
 //             self?.errorMessage = "error"
                
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                 
                completion(products)
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        
        task.resume()
    }
}
