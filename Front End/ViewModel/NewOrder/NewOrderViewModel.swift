//
//  TestViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation



/**
 Viemodel for managing Orders
 */
class NewOrderViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorMessage: String?
    @Published var pickerSelection: Int = 0
    @Published var searchTerm: String = ""

    /**
     Fetches the products from the backend
     */
    func fetchProducts() async throws {
        // Removes existing products to ensure no duplicates
        DispatchQueue.main.async {
            self.products.removeAll()
        }
        // Creates and Validate URL
        guard let url = URL(string: "http://35.246.81.166:8080/api/products") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            //Performs network request
            let (data, response) = try await URLSession.shared.data(for: request)
            //Ckeck if valid response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }

            do {
                // Tries to decode JSON data into list of products
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.products.append(contentsOf: products)
                }
            } catch {
                throw error
            }

        }
    }
    
    /**
     Returns a list of selected products
     Takes a dictionary as a parameter witht the products id as key and amount as value.
     */
    func getSelectedProducts(productsAmounts : [Int:Int]) -> [Product]{
        var selectedProducts : [Product] = []
        for product in products {
            for productamounts in productsAmounts{
                if product.productId == productamounts.key && productamounts.value>0{
                    selectedProducts.append(product)
                }
                    
            }
        }
        return selectedProducts
    }
    
    /**
     Place an order
     Takes a requested delivery date, a dictionary and a token.
     */
    func placeOrder(wishedDate: Date, orderList: [Int: Int], token: String) async throws {
        
        // Make sure no products are listed with 0 amount.
        let correctOrderList = removeObsoleteProducts(orderlist: orderList)

        // Tries to create json body
        let jsonBody = try createJSONBody(wishedDate: wishedDate, productAmounts: correctOrderList)
        
        //Create and validate url
        guard let url = URL(string: "http://35.246.81.166:8080/api/orders/createorder") else {
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
            //Try to place order
            let (_, response) = try await URLSession.shared.data(for: request)
            //Chekcs for valid http response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
        }
    }
    
    /**
     Removes product with a quantity of zero
     Returns the correct list
     */
    func removeObsoleteProducts(orderlist: [Int:Int]) -> [Int:Int]{
        var correctOrderList: [Int: Int] = [:]
        for order in orderlist {
            if order.value != 0 {
                correctOrderList[order.key] = order.value
            }
        }
        return correctOrderList    }

    /**
     Creates a JSON body for the new order request
     */
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
            "quantities": quantities
        ]

        print(jsonBody)

        // Serialize the JSON data
        guard JSONSerialization.isValidJSONObject(jsonBody) else {
            throw NSError(domain: "Invalid JSON", code: 0, userInfo: nil)
        }

        return try JSONSerialization.data(withJSONObject: jsonBody)
    }
}
