//
//  Logger.swift
//  SportsStore
//
//  Created by user on 11/16/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

let productLogger = Logger<Product>(callback: {p in
    print("Change: \(p.name) \(p.stockLevel) items in stock");
});

final class Logger<T> where T:NSObject, T:NSCopying {
    var dataItems:[T] = [];
    var callback:(T) -> Void;
    var arrayQ = DispatchQueue(label: "arrayQ", attributes: DispatchQueue.Attributes.concurrent)
    var callbackQ = DispatchQueue(label: "callbackQ", attributes: [])
    
    init(callback:@escaping (T) -> Void) {
        self.callback = callback;
    }
    
    fileprivate init(callback:@escaping (T) -> Void, protect:Bool = true) {
        self.callback = callback
        if (protect) {
            self.callback = {(item:T) in
                self.callbackQ.sync(execute: {() in
                    callback(item)
                })
            }
        }
    }
    func logItem(_ item:T) {
        arrayQ.async(flags: .barrier, execute: { () in
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        })
    }
    
    func processItems(_ callback:(T) -> Void) {
        arrayQ.sync(execute: {() in
            for item in self.dataItems {
                self.callback(item)
            }
        })
    }
    
}
