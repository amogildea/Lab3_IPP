//
//  ViewController.swift
//  SportsStore
//
//  Created by user on 11/15/16.
//  Copyright © 2016 user. All rights reserved.
//

import UIKit

class ProductTableCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    //      var productId:Int?;
    var product:Product?;
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
        DispatchQueue.main.async(execute: {
            
             NotificationCenter.default.addObserver(self,selector: #selector(ProductTableCell.handleStockLevelUpdate), name: NSNotification.Name(rawValue: "stockUpdate"), object: nil);
            
        })
     
    }
    
    func handleStockLevelUpdate(notification:NSNotification) {
        if let updatedProduct = notification.object as? Product {
            if updatedProduct.name == self.product?.name {
                stockStepper.value = Double(updatedProduct.stockLevel);
                stockField.text = String(updatedProduct.stockLevel);
            }
        }
    }
}

//var handler = { (p:Product) in
//    print("Change: \(p.name) \(p.stockLevel) items in stock");
//};
class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet var totalStockLabel: UILabel!
    @IBOutlet var dataTableView: UITableView!
    var productStore = ProductDataStore();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productStore.callback = {(p:Product) in
            for cell in self.dataTableView.visibleCells {
                if let pcell = cell as? ProductTableCell {
                    if pcell.product?.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel);
                        pcell.stockField.text = String(p.stockLevel);
                    }
                } }
            self.displayStockTotal();
        }
    // MARK: - Bridge patern example
        let bridge = EventBridge(callback: updateStockLevel); productStore.callback = bridge.inputCallback;

    
    }
    
override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (event?.subtype == UIEventSubtype.motionShake) {
            print("Shake motion detected");
            undoManager?.undo();
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count;
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row];
        let cell = dataTableView.dequeueReusableCell(withIdentifier: "ProductTableCell")
            as! ProductTableCell;
        cell.product = product;
        cell.nameLabel.text = product.name;
        cell.descriptionLabel.text = product.productDescription;
        //        cell.descriptionLabel.text = product.description;
        cell.stockStepper.value = Double(product.stockLevel);
        cell.stockField.text = String(product.stockLevel);
        
        

// MARK: - Chain of responsibility example
        
//        CellFormatter.createChain().formatCell(cell:cell);
        
        return cell;
    }
    func displayStockTotal() {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0),
                                                                     {(totals, product) -> (Int, Double) in
                                                                        return (
                                                                            totals.0 + product.stockLevel,
                                                                            totals.1 + product.stockValue
                                                                        );
        });
//
//        var factory = StockTotalFactory.getFactory(StockTotalFactory.Currency.EUR);
//        var totalAmount = factory.converter?.convertTotal(finalTotals.1);
//        var formatted = factory.formatter?.formatTotal(totalAmount!);
//        
// MARK: - Facade example
        let formatted = StockTotalFacade.formatCurrencyAmount(amount: finalTotals.1,
                                                              currency: StockTotalFacade.Currency.EUR);
        
//
        
// MARK: - Adapter and Abstract Factory example
        
//        let factory = StockTotalFactory.getFactory(curr: StockTotalFactory.Currency.USD);
//        let totalAmount = factory.converter?.convertTotal(total: finalTotals.1);
//        let formatted = factory.formatter?.formatTotal(total: totalAmount!);
        
        
        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
            + "Total Value: \(formatted!)";
    }
    
    @IBAction func stockLevelDidChange(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!;
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        
// MARK: - Needed to comment it for memento pattern example
//                        let dict = NSDictionary(objects: [product.stockLevel],
//                                                forKeys: [product.name as NSCopying]);
// MARK: - Command patern example
//                        undoManager?.registerUndo(withTarget: self,
//                                                            selector: Selector(("undoStockLevel:")),
//                                                            object: dict);
                        undoManager?.registerUndo(withTarget: self,
                                                  selector: Selector(("undoStockLevel:")),
                                                  object: nil);
                        
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value);
                        } else if let textfield = sender as? UITextField {
                            if let newValue = Int(textfield.text!){
                                product.stockLevel = newValue;
                            } }

                        // MARK: - Needed to comment it for observer pattern example
                        
//                        cell.stockStepper.value = Double(product.stockLevel);
//                        cell.stockField.text = String(product.stockLevel);
                        
                        
                        productLogger.logItem(product);
//                        logger.logItem(item: product);
                    }
                    break;
                }
            }
            displayStockTotal();
        }
    }
    
  // MARK: - Bridge patern example
    func updateStockLevel(name:String, level:Int) {
        for cell in self.dataTableView.visibleCells {
            if let pcell = cell as? ProductTableCell {
                if pcell.product?.name == name {
                    pcell.stockStepper.value = Double(level);
                    pcell.stockField.text = String(level);
                }
            } }
        self.displayStockTotal();
    }
  // MARK: - Command patern example
    
//    func undoStockLevel(data:[String:Int]) {
//        let productName = data.keys.first;
//        if (productName != nil) {
//            let stockLevel = data[productName!];
//            if (stockLevel != nil) {
//                for nproduct in productStore.products {
//                    if nproduct.name == productName! {
//                        nproduct.stockLevel = stockLevel!;
//                    }
//                }
//                updateStockLevel(name: productName!, level: stockLevel!);
//            }
//        }
//    }
// MARK: - Needed to comment method undoStockLevel for memento pattern example
    func resetState() {
        self.productStore.resetState();
    }
    
    
}

