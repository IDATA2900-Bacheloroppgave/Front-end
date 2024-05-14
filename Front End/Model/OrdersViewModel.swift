//
//  OrdersViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import Foundation

class OrdersViewModel: ObservableObject{
    @Published var orders: [Order] = []
    
    
    func fetchOrders(token: String) async throws{
        
        DispatchQueue.main.async {
            self.orders.removeAll()
        }
      
        
        guard let url = URL(string: "http://35.246.81.166:8080/api/orders") else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let headers = [
            "content-type" : "application/json",
            "authorization" : "Bearer \(token)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else{
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
            
            do{
                let orders = try JSONDecoder().decode([Order].self, from: data)
                
                for order in orders {
                           do {
                               let currentLocation = try await getCurrentLocation(orderId: order.orderId)
                               order.currentLocation = currentLocation
                           } catch {
                               print("Error fetching current location for order \(order.orderId): \(error)")
                           }
                       }
                
                DispatchQueue.main.async{
                    self.orders.append(contentsOf: orders)
                }
          
            }catch{
                print("Feil: \(error)")
                throw error
            }
        }
    }
    
    func getAmountOfProducts(order: Order) -> Int{
        var products = 0
        for _ in order.quantities {
            products += 1
        }
        return products
    }
    
    func getActiveOrders(o: [Order]) -> [Order]{
        o.filter { $0.orderStatus != "DELIVERED" && $0.orderStatus != "CANCELLED" }
        
    }
    
    func getPastOrders(o: [Order]) -> [Order]{
        o.filter { $0.orderStatus == "DELIVERED" }
    }
    
    func getCurrentLocation(orderId: Int) async throws -> String {
        guard let url = URL(string: "http://35.246.81.166:8080/api/orders/currentlocation/\(orderId)") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let headers = [
            "content-type" : "application/json",
            "authorization" : "Bearer \(orderId)"
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
            
            let currentLocation = String(data: data, encoding: .utf8) ?? ""
            return currentLocation
        } catch {
            throw error
        }
    }
    
 
}
