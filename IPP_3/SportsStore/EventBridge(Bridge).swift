//
//  EventBridge.swift
//  SportsStore
//
//  Created by user on 1/04/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation


class EventBridge {
    private let outputCallback:(String, Int) -> Void;
    init(callback:@escaping (String,Int) -> Void) {
        self.outputCallback = callback;
    }
    var inputCallback:(Product) -> Void {
        return { p in self.outputCallback(p.name,
                                          p.stockLevel); }
    }
}
