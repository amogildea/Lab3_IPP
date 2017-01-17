//
//  Utils.swift
//  SportsStore
//
//  Created by user on 11/16/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation
class Utils {
    class func currencyStringFromNumber(number:Double) -> String {
        let formatter = NumberFormatter();
        formatter.numberStyle = NumberFormatter.Style.currency;
        return formatter.string(from: NSNumber(value: number))!
    } }
