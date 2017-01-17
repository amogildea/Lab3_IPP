//
//  StockValueImplementations.swift
//  SportsStore
//
//  Created by Admin on 12/13/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation
import UIKit
protocol StockValueFormatter {
    func formatTotal(total:Double) -> String;
}
class DollarStockValueFormatter : StockValueFormatter {
    func formatTotal(total:Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total);
        return "\(formatted)";
    }
}
class PoundStockValueFormatter : StockValueFormatter {
    func formatTotal(total:Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total);

        return "£\(String(formatted.characters.dropFirst()))";
    }
}
protocol StockValueConverter {
    func convertTotal(total:Double) -> Double;
}
class DollarStockValueConverter : StockValueConverter {
    func convertTotal(total:Double) -> Double {
        return total;
    }
}
class PoundStockValueConverter : StockValueConverter {
    func convertTotal(total:Double) -> Double {
        return 0.60338 * total;
    }
}
