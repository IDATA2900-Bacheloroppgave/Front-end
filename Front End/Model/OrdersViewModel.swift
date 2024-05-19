//
//  OrdersViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import Foundation

/**
 Defines a actor for thread safe managing
 */
actor OrderStorage {
    var orders: [Order] = []
    
    func append(_ order: Order) {
        orders.append(order)
    }
}
/**
 A viewmodel for Orders
 */
class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []

    /**
     Fetches the roders from back-end
     */
    func fetchOrders(token: String) async throws {
        //Removes all orders
        DispatchQueue.main.async {
            self.orders.removeAll()
        }
        
        //Create and validate URL
        guard let url = URL(string: "http://35.246.81.166:8080/api/orders") else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let headers = [
            "content-type": "application/json",
            "authorization": "Bearer \(token)"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        do {
            //Tries to fetch data
            let (data, response) = try await URLSession.shared.data(for: request)
            
            //Checks the responsecode
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
            
            //Decode the json data
            let orders = try JSONDecoder().decode([Order].self, from: data)
            
            //Instance of the actor OrderStoreage
            let storage = OrderStorage()
            
            //Taskgroup to concurrently fetch current location
            await withTaskGroup(of: Void.self) { group in
                for order in orders {
                    group.addTask {
                        let currentLocation: String?
                        do {
                            // Fetch the current location for the order
                            currentLocation = try await self.getCurrentLocation(orderId: order.orderId, token: token)
                        } catch {
                            print("Error fetching current location for order \(order.orderId): \(error)")
                            currentLocation = nil
                        }
                        let updatedOrder = order
                        updatedOrder.currentLocation = currentLocation
                        await storage.append(updatedOrder)
                    }
                }
            }
            
            // Retrieve the updated orders from the storage
            let updatedOrders = await storage.orders
            
            // Update the orders array on the main thread
            DispatchQueue.main.async {
                self.orders.append(contentsOf: updatedOrders)
            }
            
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    /**
     Returns the amount of products
     */
    func getAmountOfProducts(order: Order) -> Int {
        return order.quantities.count
    }
    
    /**
     Return active orders
     */
    func getActiveOrders(o: [Order]) -> [Order] {
        return o.filter { $0.orderStatus != "DELIVERED" && $0.orderStatus != "CANCELLED" }
    }
    
    /**
     Returns past orders
     */
    func getPastOrders(o: [Order]) -> [Order] {
        return o.filter { $0.orderStatus == "DELIVERED" }
    }
    
    /**
     Fetches the current location of an order
     Returns the current location
     */
    func getCurrentLocation(orderId: Int, token: String) async throws -> String {
        //Create and validate URL
        guard let url = URL(string: "http://35.246.81.166:8080/api/orders/currentlocation/\(orderId)") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let headers = [
            "content-type": "application/json",
            "authorization": "Bearer \(token)"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        do {
            //Tries to fetch data
            let (data, response) = try await URLSession.shared.data(for: request)
            //Check the http response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }

            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            throw error
        }
    }
}
