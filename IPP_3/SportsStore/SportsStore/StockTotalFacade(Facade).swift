//
//  StockTotalFacade.swift
//  SportsStore
//
//  Created by Admin on 12/14/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

class StockTotalFacade {
    enum Currency {
        case USD; case GBP; case EUR;
    }
    class func formatCurrencyAmount(amount:Double, currency: Currency) -> String? {
        var stfCurrency:StockTotalFactory.Currency;
        switch (currency) {
        case .EUR:
            stfCurrency = StockTotalFactory.Currency.EUR;
        case .GBP:
            stfCurrency = StockTotalFactory.Currency.GBP;
        case .USD:
            stfCurrency = StockTotalFactory.Currency.USD;
        }
        let factory = StockTotalFactory.getFactory(curr: stfCurrency);
        let totalAmount = factory.converter?.convertTotal(total: amount);
        if (totalAmount != nil) {
            let formattedValue = factory.formatter?.formatTotal(total: totalAmount!);
            if (formattedValue != nil) {
                return formattedValue!;
            }
        }
        return nil; }
}
