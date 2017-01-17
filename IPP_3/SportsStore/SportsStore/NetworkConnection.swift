//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by Admin on 11/30/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

class NetworkConnection {
    
    private let flyweight:NetConnFlyweight;
    init() {
        self.flyweight = NetConnFlyweightFactory.createFlyweight();
    }

//    private let stockData: [String: Int] = [
//        "Kayak" : 10, "Lifejacket": 14, "Soccer Ball": 32,"Corner Flags": 1,
//        "Stadium": 4, "Thinking Cap": 8, "Unsteady Chair": 3,
//        "Human Chess Board": 2, "Bling-Bling King":4
//    ];
    
//    fileprivate let stockData: [String: Int] = [
//        "Kayak": 0, "Lifejacket": 0, "Soccer Ball": 4
//    ]
    
    func getStockLevel(_ name:String) -> Int? {
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        return self.flyweight.getStockLevel(name: name);
//        if let result = stockData[name] {
//            return result
//        }
//        else {
//            return -1
//        }
    }
    
    
}
