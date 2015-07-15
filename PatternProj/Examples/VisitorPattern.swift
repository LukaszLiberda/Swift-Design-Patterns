//
//  VisitorPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The visitor pattern is used to separate a relatively complex set of structured data classes from the functionality that may be performed upon the data that they hold.

In object-oriented programming and software engineering, the visitor design pattern is a way of separating an algorithm from an object structure on which it operates. A practical result of this separation is the ability to add new operations to existing object structures without modifying those structures. It is one way to follow the open/closed principle.

In essence, the visitor allows one to add new virtual functions to a family of classes without modifying the classes themselves; instead, one creates a visitor class that implements all of the appropriate specializations of the virtual function. The visitor takes the instance reference as input, and implements the goal through double dispatch.
*/

protocol PlanetVisitor {
    func visit(planet: PlanetAlderaan)
    func visit(planet: PlanetCoruscant)
    func visit(planet: PlanetTatooine)
}

protocol Planet {
    func accept(visitor: PlanetVisitor)
}

class PlanetAlderaan: Planet {
    func accept(visitor: PlanetVisitor) {
        visitor.visit(self)
    }
}

class PlanetCoruscant: Planet {
    func accept(visitor: PlanetVisitor) {
        visitor.visit(self)
    }
}

class PlanetTatooine: Planet {
    func accept(visitor: PlanetVisitor) {
        visitor.visit(self)
    }
}

class NameVisitor: PlanetVisitor {
    var name = ""
    
    func visit(planet: PlanetAlderaan) {
        name = "Alderaan"
    }
    
    func visit(planet: PlanetCoruscant) {
        name = "Coruscant"
    }
    
    func visit(planet: PlanetTatooine) {
        name = "Tatooine"
    }
}

/*
usage
*/

class TestVisitor {
    func test() {
        let planets: [Planet] = [PlanetAlderaan(), PlanetCoruscant(), PlanetTatooine()]
        
        let names = planets.map { (planet: Planet) -> String in
            let visitor = NameVisitor()
            planet.accept(visitor)
            return visitor.name
        }
        println()
    }
    
    func test2() {
        var list:[ElementVisitor] = [This(), That(), TheOthers()]
        
        var up:UpVisitor = UpVisitor()
        var down:DownVisitor = DownVisitor()
        
        for item in list {
            item.accept(up)
        }
        
        for item in list {
            item.accept(down)
        }
        println()
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol Visitor {
    func visit(v: This)
    func visit(v: That)
    func visit(v: TheOthers)
}

protocol ElementVisitor {
    func accept(v: Visitor)
}

class This: ElementVisitor {
    func accept(v: Visitor) {
        v.visit(self)
    }
    
    func thiss() -> String {
        return "This"
    }
}

class That: ElementVisitor {
    func accept(v: Visitor) {
        v.visit(self)
    }
    
    func that() -> String {
        return "That"
    }
}

class TheOthers: ElementVisitor {
    func accept(v: Visitor) {
        v.visit(self)
    }
    
    func theOthers() -> String {
        return "TheOthers"
    }
}

class UpVisitor: Visitor {
    func visit(v: This) {
        println("do up on \(v.thiss())")
    }
    
    func visit(v: That) {
        println("do up on \(v.that())")
    }
    
    func visit(v: TheOthers) {
        println("do up on \(v.theOthers())")
    }
}

class DownVisitor: Visitor {
    func visit(v: This) {
        println("do down on \(v.thiss())")
    }
    func visit(v: That) {
        println("do down on \(v.that())")
    }
    
    func visit(v: TheOthers) {
        println("do down on \(v.theOthers())")
    }
}















