//
//  FormatterChain.swift
//  SportsStore
//
//  Created by user on 1/04/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation


import UIKit;
class CellFormatter {
    var nextLink:CellFormatter?;
    func formatCell(cell: ProductTableCell) {
        nextLink?.formatCell(cell: cell);
    }
    class func createChain() -> CellFormatter {
        let formatter = ChessFormatter();
        formatter.nextLink = WatersportsFormatter();
        formatter.nextLink?.nextLink = DefaultFormatter();
        return formatter;
    }
}
class ChessFormatter : CellFormatter {
    override func formatCell(cell: ProductTableCell) {
        if (cell.product?.category == "Chess") {
            cell.backgroundColor = UIColor.lightGray;
        } else {
            super.formatCell(cell: cell);
        }
    }
}
class WatersportsFormatter : CellFormatter {
    override func formatCell(cell: ProductTableCell) {
        if (cell.product?.category == "Watersports") {
            cell.backgroundColor = UIColor.green;
        } else {
            super.formatCell(cell: cell);
        }
    }
}
class DefaultFormatter : CellFormatter {
    override func formatCell(cell: ProductTableCell) {
        cell.backgroundColor = UIColor.yellow;
    }
}
