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
    @Published var pickerSelection: Int = 0  // Added to manage picker selection state
    @Published var searchTerm: String = ""   // Added to manage search term state

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

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.products.append(contentsOf: products)
                }
            } catch {
                print("MISTAKE")
                throw error
            }

        }
    }

    func placeOrder(wishedDate: Date, orderList: [Int: Int], token: String) async throws {
        print("PLACED ORDER")

        let jsonBody = try createJSONBody(wishedDate: wishedDate, productAmounts: orderList)

        let urlString = "http://35.246.81.166:8080/api/orders/createorder"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let headers = [
            "content-type": "application/json",
            "authorization": "Bearer \(token)"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonBody

        do {
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

        // Initialize an empty array to hold the quantities
        var quantities = [[String: Any]]()

        // Map productAmounts to the required JSON structure
        for (productId, quantity) in productAmounts {
            let productDict: [String: Any] = ["productId": productId]
            let quantityDict: [String: Any] = [
                "productQuantity": quantity,
                "product": productDict  // Nested "product" dictionary
            ]
            // Append each dictionary to the quantities array
            quantities.append(quantityDict)
        }

        // Construct JSON body
        let jsonBody: [String: Any] = [
            "wishedDeliveryDate": wishedDateString,
            "quantities": quantities  // This is the list of dictionaries with "productQuantity" and nested "product"
        ]

        print(jsonBody)

        // Serialize the JSON data
        guard JSONSerialization.isValidJSONObject(jsonBody) else {
            throw NSError(domain: "Invalid JSON", code: 0, userInfo: nil)
        }

        return try JSONSerialization.data(withJSONObject: jsonBody)
    }
}
