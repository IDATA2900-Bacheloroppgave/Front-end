//
//  StoresViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 16/04/2024.
//

import Foundation

/**
 A viemodel for managing Store data
 */
class StoresViewModel: ObservableObject{
    @Published var stores: [Store] = []
    
 
    /**
     Fetches the list of stores from Back-End
     Throws error if unsusccessfull
     */
    func fetchStores() async throws{
       
        // Creates and Validate URL
        guard let url = URL(string: "http://35.246.81.166:8080/api/stores") else {
            print("Invalid URL")
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       

        do{
            //Performs networkrequest
            let (data, response) = try await URLSession.shared.data(for: request)
            
            //Check if valid response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else{
                print("Error with the response, unexpected status code: \(String(describing: response))")
                throw NSError(domain: "Response Error", code: 0, userInfo: nil)
            }
            
            do{
                //Tries to decode JSON data into a list of Stores
                let stores = try JSONDecoder().decode([Store].self, from: data)
                DispatchQueue.main.async{
                    self.stores.append(contentsOf: stores)
                }
            }catch{
                throw error
            }
        }
    }
}
