//
//  OrdersViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import Foundation

actor OrderStorage {
    var orders: [Order] = []
    
    func append(_ order: Order) {
        orders.append(order)
    }
}

class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []

    func fetchOrders(token: String) async throws {
        DispatchQueue.main.async {
            self.orders.removeAll()
        }

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
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }

            let orders = try JSONDecoder().decode([Order].self, from: data)
            
            let storage = OrderStorage()
            
            await withTaskGroup(of: Void.self) { group in
                for order in orders {
                    group.addTask {
                        let currentLocation: String?
                        do {
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
            
            let updatedOrders = await storage.orders
            
            DispatchQueue.main.async {
                self.orders.append(contentsOf: updatedOrders)
            }
            
        } catch {
            print("Error: \(error)")
            throw error
        }
    }

    func getAmountOfProducts(order: Order) -> Int {
        return order.quantities.count
    }

    func getActiveOrders(o: [Order]) -> [Order] {
        return o.filter { $0.orderStatus != "DELIVERED" && $0.orderStatus != "CANCELLED" }
    }

    func getPastOrders(o: [Order]) -> [Order] {
        return o.filter { $0.orderStatus == "DELIVERED" }
    }

    func getCurrentLocation(orderId: Int, token: String) async throws -> String {
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
            let (data, response) = try await URLSession.shared.data(for: request)
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
