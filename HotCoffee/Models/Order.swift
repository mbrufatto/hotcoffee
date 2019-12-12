//
//  Order.swift
//  HotCoffee
//
//  Created by Marcio Brufatto on 11/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//
import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

extension Order {
    
    static var all: Resource<[Order]> = {
         guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
                   fatalError("URL is incerrect!")
               }
        
        return Resource<[Order]>(url: url)
    }()
    
    static func create(viewModel: AddCoffeeOrderViewModel) -> Resource<Order?> {
        
        let order = Order(viewModel)
        
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incerrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = .post
        resource.body = data
        
        return resource
    }
}

extension Order {
    
    init?(_ addCoffeeOrderViewModel: AddCoffeeOrderViewModel) {
        guard
            let name = addCoffeeOrderViewModel.name,
            let email = addCoffeeOrderViewModel.email,
            let selectedType = CoffeeType(rawValue: (addCoffeeOrderViewModel.selectedType!.lowercased())),
            let selectedSize = CoffeeSize(rawValue: addCoffeeOrderViewModel.selectedSize!.lowercased()) else {
                return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
        
    }
}
