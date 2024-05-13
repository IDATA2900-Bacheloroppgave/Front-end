//
//  OrderService.swift
//  Front End
//
//  Created by Siri Sandnes on 12/05/2024.
//
import Foundation

protocol OrderServiceProtocol {
    func fetchOrders(token: String) async throws -> [Order]
}

class OrderService: OrderServiceProtocol {
    func fetchOrders(token: String) async throws -> [Order] {
        guard let url = URL(string: "http://35.246.81.166:8080/api/orders") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let headers = [
            "content-type": "application/json",
            "authorization": "Bearer \(token)"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Response Error", code: 0, userInfo: nil)
        }

        return try JSONDecoder().decode([Order].self, from: data)
    }
}
