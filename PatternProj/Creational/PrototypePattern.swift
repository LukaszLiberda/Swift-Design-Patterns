//
//  PrototypePattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The prototype pattern is used to instantiate a new object by copying all of the properties of an existing object, creating an independent clone. This practise is particularly useful when the construction of a new object is inefficient.


The prototype pattern is a creational design pattern in software development. It is used when the type of objects to create is determined by a prototypical instance, which is cloned to produce new objects. This pattern is used to:

avoid subclasses of an object creator in the client application, like the abstract factory pattern does.
avoid the inherent cost of creating a new object in the standard way (e.g., using the 'new' keyword) when it is prohibitively expensive for a given application.
To implement the pattern, declare an abstract base class that specifies a pure virtual clone() method. Any class that needs a "polymorphic constructor" capability derives itself from the abstract base class, and implements the clone() operation.

The client, instead of writing code that invokes the "new" operator on a hard-coded class name, calls the clone() method on the prototype, calls a factory method with a parameter designating the particular concrete derived class desired, or invokes the clone() method through some mechanism provided by another design pattern.

The mitotic division of a cell — resulting in two identical cells — is an example of a prototype that plays an active role in copying itself and thus, demonstrates the Prototype pattern. When a cell splits, two cells of identical genotype result. In other words, the cell clones itself.[1]
*/

class ChungasRevengeDisplay {
    var name: String?
    let font: String
    
    init(font: String) {
        self.font = font
    }
    
    func clone() -> ChungasRevengeDisplay {
        return ChungasRevengeDisplay(font: self.font)
    }
}

/*
usage
*/

class TestPrototype {
    func test() {
        let prototype = ChungasRevengeDisplay(font: "Project")
        let philippe = prototype.clone()
        philippe.name = "Philippe"
        
        let christoph = prototype.clone()
        christoph.name = "Christoph"
        
        let eduardo = prototype.clone()
        eduardo.name = "Eduardo"
        println()
    }
    
    func test2() {
        var pBin:BinPrototypesModule = BinPrototypesModule()
        pBin.addBinPrototype(Bin())
        pBin.addBinPrototype(Bin())
        pBin.addBinPrototype(TheOther())
        
        var binObject: [BinPrototype] = []
        var total: Int = 0
        
        var sty: [String] = ["The other", "Bin", "The", "Bin", "The other", "Bin", "other", "Bin", "The other", "The other"]
        
        for i in 0...9 {
            if let binObj = pBin.findAndClone(sty[i])  {
                binObject.append(binObj)
                total++
            }
        }
        
        for obj in binObject {
            println("obj \(obj)")
            if let bObj = obj as? BinCommand {
                println("\(bObj)--> ")
                bObj.binExecute()
            }
        }
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


protocol BinPrototype {
    func clone() -> BinPrototype
    func name() -> String
}

protocol BinCommand {
    func binExecute()
}

class BinPrototypesModule {
    private var prototypes: [BinPrototype] = []
    private var total: Int = 0
    
    func addBinPrototype(obj: BinPrototype) {
        prototypes.append(obj) 
        total++
    }
    
    func findAndClone(name: String) -> BinPrototype? {
        for binProtot in prototypes {
            if binProtot.name() == name {
                return binProtot
            }
        }
        return nil
    }
}

class Bin: BinPrototype, BinCommand {
    func clone() -> BinPrototype {
        return Bin()
    }
    
    func name() -> String {
        return "Bin"
    }
    
    func binExecute() {
        println("Bin execute")
    }
}

class TheOther: BinPrototype, BinCommand {
    func clone() -> BinPrototype {
        return TheOther()
    }
    
    func name() -> String {
        return "The other"
    }
    
    func binExecute() {
        println("The other execute")
    }
}



























