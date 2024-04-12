//
//  TestViewModel.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorMessage: String?
    
    private let service = ProductsDataService()
    
    init(){
        fetchProductData()
    }
    
    func fetchProductData() {
        service.fetchProducts { listOfProducts in
            DispatchQueue.main.async{
                self.products.append(contentsOf: listOfProducts)
            }
        }
    }
}

