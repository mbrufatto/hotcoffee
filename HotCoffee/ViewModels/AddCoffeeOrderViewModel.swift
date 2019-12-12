//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Marcio Brufatto on 11/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
