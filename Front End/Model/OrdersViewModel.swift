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
                print("trying to decode json resoonse")
                print("data:\(data)")
                let order = try JSONDecoder().decode([Order].self, from: data)
                DispatchQueue.main.async{
                    self.orders.append(contentsOf: order)
                    for _ in self.orders {
                    }
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
    
    func getActiveOrders() -> [Order]{
        var activeOrders: [Order] = []
        for order in orders {
            if order.orderStatus != "DELIVERED" && order.orderStatus != "CANCELLED"{
                activeOrders.append(order)
                print(order.orderStatus)
            }
        }
        print(activeOrders)
        return activeOrders
        
    }
    
    func getPastOrders() -> [Order]{
        var pastOrders: [Order] = []
        for order in orders {
            if order.orderStatus == "DELIVERED"{
                pastOrders.append(order)
                print(order.orderStatus)
            }
        }
        print(pastOrders)
        return pastOrders
    }
    
    
    
    
//    func fetchOrdersById(token: String, id: Int) async throws{
//        
//        guard let url = URL(string: "http://35.246.81.166:8080/api/orders/\(id)") else {
//            print("Invalid URL")
//            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
//        }
//        
//        let headers = [
//            "content-type" : "application/json",
//            "authorization" : "Bearer \(token)"
//        ]
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        
//        
//        do{
//            let (data, response) = try await URLSession.shared.data(for: request)
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else{
//                print("Error with the response, unexpected status code: \(String(describing: response))")
//                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
//            }
//            
//            do{
//                print("trying to decode json resoonse")
//                print("data:\(data)")
//                let order = try JSONDecoder().decode([Order].self, from: data) //FEIL HER
//                print("Order \(order)")
//                DispatchQueue.main.async{
//                    self.orders.append(contentsOf: order)
//                }
//            }catch{
//                print("AAAA MISTAKE")
//                throw error
//            }
//        }
//        
//    }
    
}
