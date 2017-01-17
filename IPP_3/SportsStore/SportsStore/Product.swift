//
//  Product.swift
//  SportsStore
//
//  Created by user on 11/16/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

class Product : NSObject,NSCopying {
    private(set) var name:String;
    private(set) var productDescription:String;
    private(set) var category:String;
    private var stockLevelBackingValue:Int = 0;
    private var priceBackingValue:Double = 0;
    required init(name:String, description:String, category:String, price:Double,
                  stockLevel:Int) {
        self.name = name;
        self.productDescription = description;
        self.category = category;
        super.init();
        self.price = price;
        self.stockLevel = stockLevel;
    }
    var stockLevel:Int {
        get { return stockLevelBackingValue;}
      
        set {
 
            stockLevelBackingValue = max(0, newValue);
        
            // MARK: - Mediator patern as Notification Center example
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stockUpdate"),
                                            object: self);
        }
    }
    private(set) var price:Double {
        get { return priceBackingValue;}
        set { priceBackingValue = max(1, newValue);}
    }
    var stockValue:Double {
        get {
            return price * Double(stockLevel);
        }
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: self.name, description: self.description,
                       category: self.category, price: self.price,
                       stockLevel: self.stockLevel);
    }
    class func createProduct(name:String, description:String, category:String,
                             price:Double, stockLevel:Int) -> Product {
        return Product(name:name, description: description, category: category,
                       price: price, stockLevel: stockLevel);
    }
}

class ProductComposite : Product {
    private let products:[Product];
    required init(name:String, description:String, category:String,
                  price:Double, stockLevel:Int) {
        fatalError("Not implemented");
    }
    init(name:String, description:String, category:String, stockLevel:Int,
         products:Product...) {
        self.products = products;
        super.init(name: name, description: description, category: category,price: 0, stockLevel: stockLevel);
    }
    override var price:Double {
        get { return products.reduce( 0,{total, p in return total + p.price}); }
        //set { /* do nothing */ }
    }
}
class CompositeLeaf :Product{
    private let products:[Product];
    required init(name:String, description:String, category:String,
                  price:Double, stockLevel:Int) {
        fatalError("Not implemented");
    }
    init(name:String, description:String, category:String, stockLevel:Int,
         products:Product...) {
        self.products = products;
        super.init(name: name, description: description, category: category,price: 0, stockLevel: stockLevel);
    }
    override var name: String {
        get { return self.name ; }
        //set { /* do nothing */ }
    }
}

//import Foundation
//
//class Product : NSObject,NSCopying {
//    private(set) var name:String;
//    private(set) var productDescription:String;
//    //    private(set) var description:String;
//    private(set) var category:String;
//    private var stockLevelBackingValue:Int = 0;
//    private var priceBackingValue:Double = 0;
//    private var salesTaxRate:Double = 0.2;
//    
//required init(name:String, description:String, category:String, price:Double,
//                  stockLevel:Int) {
//        self.name = name;
//        self.productDescription = description;
//        //        self.description = description;
//        self.category = category;
//        
//        super.init();
//        
//        self.price = price;
//        self.stockLevel = stockLevel;
//}
//var stockLevel:Int {
//        get { return stockLevelBackingValue;}
//        set { stockLevelBackingValue = max(0, newValue);}
//}
//private(set) var price:Double {
//        get { return priceBackingValue;}
//        set { priceBackingValue = max(1, newValue);}
//}
//var stockValue:Double {
//        get {
//            return (price * (1 + salesTaxRate)) * Double(stockLevel);
//            //            return price * Double(stockLevel);
//        }
//}
//public func copy(with zone: NSZone? = nil) -> Any {
//        return Product(name: self.name, description: self.description,
//                       category: self.category, price: self.price,
//                       stockLevel: self.stockLevel);
//}
//var upsells:[UpsellOpportunities]{
//        get{
//            return Array();
//        }
//}
//enum UpsellOpportunities {
//        case SwimmingLessons;
//        case MapOfLakes;
//        case SoccerVideos;
//}
//class func createProduct(name:String, description:String, category:String, price: Double, stockLevel: Int) ->Product{
//        
//        var productType:Product.Type;
//        
//        switch category {
//        case "WaterSports":
//            productType = WaterSportsProduct.self;
//        case "Soccer":
//            productType = SoccerProduct.self;
//            
//        default:
//            productType = Product.self;
//        }
//        return productType.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel);
//}
//class WaterSportsProduct: Product {
//        required init(name:String, description:String, category:String, price: Double, stockLevel: Int) {
//            super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel);
//            salesTaxRate = 0.10;
//        }
//        override var upsells: [Product.UpsellOpportunities]{
//            return [UpsellOpportunities.SwimmingLessons, UpsellOpportunities.MapOfLakes];
//        }
//}
//class SoccerProduct: Product {
//        required init(name:String, description:String, category:String, price: Double, stockLevel: Int) {
//            super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel);
//            salesTaxRate = 0.25;
//        }
//        override var upsells: [Product.UpsellOpportunities]{
//            return [UpsellOpportunities.SoccerVideos];
//        }
//    }
//    //    func copyWithZone(zone: NSZone) -> AnyObject {
//    //        return Product(name: self.name, description: self.description,
//    //        category: self.category, price: self.price,
//    //        stockLevel: self.stockLevel);
//    //        }
//    //    required init(coder aDecoder: NSCoder) {   }
//    //
//    //    func encode(with aCoder: NSCoder) {   }
//    
//}
