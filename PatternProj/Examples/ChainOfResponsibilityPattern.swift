//
//  ChainOfResponsibilityEx1.swift
//  
//
//  Created by lukasz on 05/07/15.
//
//

import UIKit
import Swift
import Foundation


// Design Pattern

// Behavioral
/*
--- Chain of responsibility delegates commands to a chain of processing objects.

In object-oriented design, the chain-of-responsibility pattern is a design pattern consisting of a source of command objects and a series of processing objects.[1] Each processing object contains logic that defines the types of command objects that it can handle; the rest are passed to the next processing object in the chain. A mechanism also exists for adding new processing objects to the end of this chain.

In a variation of the standard chain-of-responsibility model, some handlers may act as dispatchers, capable of sending commands out in a variety of directions, forming a tree of responsibility. In some cases, this can occur recursively, with processing objects calling higher-up processing objects with commands that attempt to solve some smaller part of the problem; in this case recursion continues until the command is processed, or the entire tree has been explored. An XML interpreter might work in this manner.

This pattern promotes the idea of loose coupling, which is considered a programming best practice.
*/


class MoneyCoin {
    let value: Int
    var quantity: Int
    var nextCoin: MoneyCoin?
    
    init(value: Int, quantity: Int, nextMoney: MoneyCoin?) {
        self.value = value
        self.quantity = quantity
        self.nextCoin = nextMoney
    }
    
    func canGiveTheChange(var v: Int) -> Bool {
        func canTakeBill(want: Int) -> Bool {
            return (want / self.value) > 0
        }
        
        var q = self.quantity
        
        while canTakeBill(v) {
            if q == 0 {
                break
            }
            
            v -= self.value
            q -= 1
        }
        
        if v == 0 {
            return true
        } else if let next = self.nextCoin {
            return next.canGiveTheChange(v)
        }
        
        return false
    }
}

class Wallet {
    private var hundred: MoneyCoin
    private var fifty: MoneyCoin
    private var twenty: MoneyCoin
    private var ten: MoneyCoin
    private var five: MoneyCoin
    
    private var startTheChange: MoneyCoin {
        return self.hundred
    }
    
    init(hundred: MoneyCoin, fifty: MoneyCoin, twenty: MoneyCoin, ten: MoneyCoin, five: MoneyCoin) {
        self.hundred = hundred
        self.fifty = fifty
        self.twenty = twenty
        self.ten = ten
        self.five = five
    }
    
    func canGiveTheChange(value: Int) -> String {
        return "Can give the change \(self.startTheChange.canGiveTheChange(value))"
    }
}



class TestChainOfResponsibility {
    func test() {
        let five = MoneyCoin(value: 5, quantity: 5, nextMoney: nil)
        let ten = MoneyCoin(value: 10, quantity: 3, nextMoney: five)
        let twenty = MoneyCoin(value: 20, quantity: 3, nextMoney: ten)
        let fifty = MoneyCoin(value: 50, quantity: 3, nextMoney: twenty)
        let hundred = MoneyCoin(value: 100, quantity: 3, nextMoney: fifty)
        
        var wallet = Wallet(hundred: hundred, fifty: fifty, twenty: twenty, ten: ten, five: five)
        wallet.canGiveTheChange(575)
        wallet.canGiveTheChange(25)
        wallet.canGiveTheChange(229)
        wallet.canGiveTheChange(15)
        println()
    }
    
    func test2() {
        let cat1 = Category(name: "Chess")
        let cat2 = Category(name: "Watersports")
        
        var cell1 = ProductCell(product: cat1, backgroundColor: "")
        var cell2 = ProductCell(product: cat2, backgroundColor: "")
        var cell3 = ProductCell(product: nil, backgroundColor: "")
        
        
        CellFormatter.createChain().formatCell(cell1)
        CellFormatter.createChain().formatCell(cell2)
        CellFormatter.createChain().formatCell(cell3)
        println()
    }
    
    func test3() {
        var h1 = ConcreteHandler1()
        var h2 = ConcreteHandler2()
        var h3 = ConcreteHandler3()
        
        h1.successor = h2
        h2.successor = h3
        
        var requests: [Int] = [1, 2, 5, 7, 11, 13, 17, 19, 23, 29, 31];
        
        for req in requests {
            h1.handlerRequest(req)
        }
        println()
    }
}


/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
next example
*/

class Category: NSObject {
    let catName: String
    
    init(name: String) {
        self.catName = name
        println("cat name: \(self.catName)")
    }
}

class ProductCell {
    var product: Category?
    var backgroundColor: String
    
    init(product: Category? = nil, backgroundColor: String) {
        self.product = product
        self.backgroundColor = backgroundColor
        
        println(product)
        println("cell p \(self.product?.catName)")
    }
}

class CellFormatter {
    var name: String
    var nextFormatter: CellFormatter?
    
    func formatCell(cell: ProductCell) {
        nextFormatter?.formatCell(cell)
        println(" name : \(cell.product?.catName)")
    }
    
    init(name: String) {
        self.name = name
        println("init cell \(name)")
    }
    
    class func createChain() -> CellFormatter {
        let formatter = ChessFormater(name: "ch1")
        formatter.nextFormatter = WatersportsFormatter(name: "wat1")
        formatter.nextFormatter?.nextFormatter = DefaultFormatter(name: "def1")
        return formatter
    }
}

class ChessFormater: CellFormatter {
    override func formatCell(cell: ProductCell) {
        if (cell.product?.catName == "Chess") {
            cell.backgroundColor = "color"
        } else {
            super.formatCell(cell)
        }
        
        println("cat name \(cell.product?.catName)")
    }
}

class WatersportsFormatter: CellFormatter {
    override func formatCell(cell: ProductCell) {
        if (cell.product?.catName == "Watersports") {
            cell.backgroundColor = "color"
        } else {
            super.formatCell(cell)
        }
    }
}

class DefaultFormatter: CellFormatter {
    override func formatCell(cell: ProductCell) {
        cell.backgroundColor = "color"
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Handler {
    var successor: Handler?
    
    func handlerRequest(request: Int) {
        
    }
}

class ConcreteHandler1: Handler {
    override func handlerRequest(request: Int) {
        if request >= 0 && request < 10 {
            println("\(self) handler request \(request)")
        } else if successor != nil {
            successor?.handlerRequest(request)
        }
    }
}

class ConcreteHandler2: Handler {
    override func handlerRequest(request: Int) {
        if request >= 10 && request < 20 {
            println("\(self) handler request \(request)")
        } else if successor != nil {
            successor?.handlerRequest(request)
        }
    }
}

class ConcreteHandler3: Handler {
    override func handlerRequest(request: Int) {
        if request >= 20 && request < 30 {
            println("\(self) handler request \(request)")
        } else if successor != nil {
            successor?.handlerRequest(request)
        }
    }
}









