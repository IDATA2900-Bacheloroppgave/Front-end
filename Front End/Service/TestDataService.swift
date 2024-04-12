//
//  TestDataService.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

class TestDataService{
    func fetchProductData(completion:) {
        guard let url = URL(string: "ht://35.246.81.166:8080/api/products") else {
            print("Invalid URL")
   //         self.errorMessage = "Invalid url"
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                DispatchQueue.main.async{
 //                  self?.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                DispatchQueue.main.async{
 //                   self?.errorMessage = "error"
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
  //                  self?.products = products
                    print("decoded products:")
                    for product in products {
                        print(product.name)
                        print(product.productId)
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        
        task.resume()
    }
}
