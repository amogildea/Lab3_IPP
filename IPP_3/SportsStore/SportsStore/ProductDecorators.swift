//
//  ProductDecorators.swift
//  SportsStore
//
//  Created by Admin on 12/14/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation


class PriceDecorator : Product {
    let wrappedProduct:Product;
    required init(name:String, description:String, category:String,
                  price:Double, stockLevel:Int) {
        fatalError("Not supported");
}
init(product:Product) {
    self.wrappedProduct = product;
    super.init(name: product.name, description: product.productDescription,
               category: product.category, price: product.price,
               stockLevel: product.stockLevel);
    }
}
class LowStockIncreaseDecorator : PriceDecorator {
    override var price:Double {
        var price = wrappedProduct.price;
        if (stockLevel <= 5) {
            print("Price before : \(price) ");
            price = price * 1.5;
            print("Price after : \(price) ");
        }
        return price;
    }
}
class SoccerDecreaseDecorator : PriceDecorator {
    override var price:Double {
         print("Price Soccer Balls : \(super.wrappedProduct.price) ");
        return super.wrappedProduct.price * 0.5;
    }
}
