//
//  TestViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

class TestViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    func fetchProductData() {
        guard let url = URL(string: "http://35.246.81.166:8080/api/products") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self?.products = products
                    print("decoded products:")
                    for product in products {
                        print(product.name)
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        
        task.resume()
    }
}

struct Product: Codable {
    var productId: Int
    var name, description, supplier: String
    var bestBeforeDate: String
    var productType: String
    var price: Double
    var gtin: Int
    var batch: Int
    var inventory: Inventory?
    var packaging: Packaging
}

struct Inventory: Codable {
    var totalStock, reservedStock, availableStock: Int
}

struct Packaging: Codable {
    var packageType: String
    var quantityPrPackage, weightInGrams: Int
    var dimensionInCm3: Double // Assuming this should be Double as per your JSON
}


