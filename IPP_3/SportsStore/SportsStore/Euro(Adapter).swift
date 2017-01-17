//
//  Euro.swift
//  SportsStore
//
//  Created by Admin on 12/14/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation


class EuroHandler {
    func getDisplayString(amount:Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: amount); return "€\(String(formatted.characters.dropFirst()))";
    }
    func getCurrencyAmount(amount:Double) -> Double {
        return 0.76164 * amount;
    }
}
