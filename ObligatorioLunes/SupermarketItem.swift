//
//  SupermarketItem.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 1/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
class SupermarketItem{
    var quantity : Int
    let price : Int
    let name: String
    //let category: CategoryType
    //let image: String
    
    init(quantity: Int, price: Int, name:String /*, category:CategoryType , image:String*/) {
        self.quantity = quantity
        self.price = price
        self.name = name
        //self.category = category
       // self.image = image
    }
    
}
/*enum CategoryType:String{
    case fruits = "Fruit"
    case veggies = "Veggies"
}*/
